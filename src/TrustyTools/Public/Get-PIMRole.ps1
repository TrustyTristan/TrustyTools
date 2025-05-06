<#
.SYNOPSIS
    Gets all Entra ID PIM roles for the signed-in user using Microsoft Graph API.
.DESCRIPTION
    Stores eligible PIM roles in userprofile for use in "Request-PIMActivation"
.EXAMPLE
    Get-PIMRole -Tenant "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
    Activate all roles
.PARAMETER TenantId
    Specifies the Tenant Id
.NOTES
    Inspiration: Sankara Narayanan M S
    Link: https://github.com/SankaraHQ/PIM-AutoActivator
.COMPONENT
    TrustyTools
#>

function Get-PIMRole {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
            HelpMessage = 'Tenant Id is required')]
        [ValidateNotNullOrEmpty()]
        [string]$TenantId
    )

    BEGIN {
        $PIMPath = Join-Path -Path (Split-Path $Profile) -ChildPath "PIMs"
        New-Item -Path $PIMPath -ItemType Directory -ErrorAction SilentlyContinue | Out-Null
        $EligiblePIMRoles = New-Object System.Collections.Generic.List[System.Object]
    }

    PROCESS {
        # Connect to Graph
        try {
            Connect-MgGraph -TenantId $tenantId -Scopes "RoleEligibilitySchedule.Read.Directory, RoleManagement.ReadWrite.Directory, RoleManagement.Read.Directory, RoleManagement.Read.All, RoleEligibilitySchedule.ReadWrite.Directory" -NoWelcome -ErrorAction Stop
        } catch {
            Write-Error "Unable to connect to MS Graph"
            Write-Error $_.Exception.Message
            break
        }

        # Get user id
        $MgContext = Get-MgContext
        if ( $MgContext ) {
            Write-Information -MessageData "`nSuccessfully connected to $($MgContext.AppName)" -InformationAction Continue
            try {
                $CurrentUser = Get-MgUser -UserId $MgContext.Account -ErrorAction Stop
            } catch {
                Write-Error "Unable to fetch users id"
                Write-Error $_.Exception.Message
            }
        } else {
            Write-Error "Unable to connect to MS Graph"
            break
        }

        # Get all role definitions
        try {
            Write-Information -MessageData "Getting all role definitions..." -InformationAction Continue
            $AllRoleDefinitions = Get-MgRoleManagementDirectoryRoleDefinition -ErrorAction Stop
        } catch {
            Write-Error $_.Exception.Message
        }

        # Get eligible roles
        try {
            Write-Information -MessageData "Getting eligible roles for $($CurrentUser.UserPrincipalName)..." -InformationAction Continue
            $EligibleRoles = Get-MgRoleManagementDirectoryRoleEligibilityScheduleInstance -Filter "principalId eq '$($CurrentUser.Id)'" -ErrorAction Stop
        } catch {
            Write-Error $_.Exception.Message
        }

        # Create nice file
        foreach ( $EligibleRole in $EligibleRoles ) {
            $RoleDefinition = $AllRoleDefinitions | Where-Object { $_.Id -eq $EligibleRole.RoleDefinitionId }
            $CleanDefinition = [PSCustomObject]@{
                TenantId                  = $TenantId
                UserPrincipalName         = $CurrentUser.UserPrincipalName
                DisplayName               = $CurrentUser.DisplayName
                PrincipalId               = $EligibleRole.PrincipalId
                AppScopeId                = $EligibleRole.AppScopeId
                DirectoryScopeId          = $EligibleRole.DirectoryScopeId
                Id                        = $EligibleRole.Id
                RoleDefinitionId          = $EligibleRole.RoleDefinitionId
                EndDateTime               = $EligibleRole.EndDateTime
                MemberType                = $EligibleRole.MemberType
                RoleEligibilityScheduleId = $EligibleRole.RoleEligibilityScheduleId
                StartDateTime             = $EligibleRole.StartDateTime
                Description               = $RoleDefinition.Description
                RoleName                  = $RoleDefinition.DisplayName
                IsBuiltIn                 = $RoleDefinition.IsBuiltIn
            }
            $EligiblePIMRoles.Add( $CleanDefinition  )
        }

        $EligiblePIMRoles | Select-Object -Property RoleName, Description

    }

    END {
        $EligiblePIMRoles | ConvertTo-Json | Out-File -FilePath ( Join-Path -Path $PIMPath -ChildPath eligible_roles.json ) -Force
        Disconnect-MgGraph | Out-Null
        Write-Information -MessageData "`nDisconnected from MS Graph.`n" -InformationAction Continue
    }

}