<#
.SYNOPSIS
    Activates Entra ID PIM eligible roles for the signed-in user using Microsoft Graph API.
.DESCRIPTION
    This PowerShell script allows selective or bulk activation of eligible Entra ID roles via Microsoft Graph.
.EXAMPLE
    Request-PIMActivation -Justification "To perform work in Intune"
    As a user, you may run this to activate any particular eligible roles that's assigned to your account
.EXAMPLE
    Request-PIMActivation -Justification "To perform work in Intune" -Roles "Intune Administrator" -Duration 3
    Specify the role and duration
.EXAMPLE
    Request-PIMActivation -Justification "To do all the work" -All
    Activate all roles
.PARAMETER TenantId
    Specifies the Tenant Id
.PARAMETER Roles
    Specifies the roles you want to activate
.PARAMETER Justification
    Provide a reason for the account elevation
.PARAMETER Duration
    Duration in hours for elevation. (1-8)
.PARAMETER All
    Switch statment to activate all eligible roles
.NOTES
    Inspiration: Sankara Narayanan M S
    Link: https://github.com/SankaraHQ/PIM-AutoActivator
.COMPONENT
    TrustyTools
#>

function Request-PIMActivation {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false,
            HelpMessage = 'Please incldude the tenant id')]
        [string]$TenantId,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Specify the name of the role')]
        [array]$Roles,

        [Parameter(Mandatory = $true,
            HelpMessage = 'Reason for elevating privilege.')]
        [string]$Justification,

        [ValidateRange(1, 8)]
        [int]$Duration = 8,

        [switch]$All
    )

    BEGIN {
        $PIMPath = Join-Path -Path ( Split-Path $Profile ) -ChildPath "PIMs"
        $PIMPath = Join-Path -Path $PIMPath -ChildPath "eligible_roles.json"
        if ( -not ( Test-Path $PIMPath ) ) {
            Write-Error "No eligible PIM roles found"
            if ( -not $TenantId ) {
                $TenantId = Read-Host "Enter Tenant Id"
            }
            Get-PIMRole -TenantId $TenantId
        }
        $EligiblePIMRoles = ( Get-Content -Path $PIMPath ) | ConvertFrom-Json
        if ( $TenantId -and ( $TenantId -ne $EligiblePIMRoles.TenantId[0] ) ) {
            Write-Error "Specified Tenant Id `"$TenantId`" does not match stored value `"$($EligiblePIMRoles.TenantId[0])`""
            break
        } else {
            $TenantId = $EligiblePIMRoles.TenantId[0]
        }

        # Check specified roles
        $selectedIndices = New-Object System.Collections.Generic.List[System.Object]
        if ( $Roles ) {
            foreach ( $Role in $Roles ) {
                if ( $EligiblePIMRoles.RoleName -contains $Role ) {
                    Write-Debug "Role: $Role"
                    Write-Debug "Index: $($EligiblePIMRoles.RoleName.Indexof( $Role ))"
                    $selectedIndices.Add(
                        ( $EligiblePIMRoles.RoleName.Indexof( $Role ) )
                    )
                } else {
                    Write-Error "Specified role`"$Role`" is not in eligibile roles`""
                    break
                }
            }
        }
    }

    PROCESS {
        # Connect to Graph
        try {
            Connect-MgGraph -TenantId $TenantId -Scopes "RoleEligibilitySchedule.Read.Directory, RoleManagement.ReadWrite.Directory, RoleManagement.Read.Directory, RoleManagement.Read.All, RoleEligibilitySchedule.ReadWrite.Directory" -NoWelcome -ErrorAction Stop
        } catch {
            Write-Error "Unable to connect to MS Graph"
            Write-Error $_.Exception.Message
            break
        }

        if ( -not ( $All -or ( $selectedIndices.count -gt 0 ) ) ) {
            # Show eligible roles
            Write-Information -MessageData "`nEligible Roles:" -InformationAction Continue
            $RoleIndex = 1
            $EligiblePIMRoles | ForEach-Object {
                Write-Information -MessageData "$RoleIndex) $($_.RoleName) - $($_.Description)" -InformationAction Continue
                $RoleIndex++
            }

            # Prompt user input
            do {
                $selectedInput = Read-Host "`nEnter comma-separated numbers for roles to activate (e.g., 1,3)"
                $selectedIndices = $selectedInput -split ',' | ForEach-Object { $_.Trim() } | Where-Object { $_ -match '^\d+$' }
                if ( $selectedIndices ) {
                    $isValid = $true
                } else {
                    Write-Information -MessageData "Invalid selection: `'$index`'. Please enter valid indices." -InformationAction Continue
                    $isValid = $false
                }

                foreach ( $index in $selectedIndices ) {
                    if ( $index -lt 1 -or $index -gt $EligiblePIMRoles.Count ) {
                        Write-Information -MessageData "Invalid selection: `'$index`'. Please enter valid indices." -InformationAction Continue
                        $isValid = $false
                        break
                    }
                }
            } while ( -not $isValid )

            # Convert to int and subtract 1
            $selectedIndices = $selectedIndices | ForEach-Object { [int]$_ - 1 }
        } elseif ( $All ) {
            $selectedIndices = $EligiblePIMRoles.Index
        }


        # Activate selected roles
        foreach ( $index in $selectedIndices ) {

            $SelectedRole = $EligiblePIMRoles[ $index ]

            Write-Information -MessageData "Activating role: $($selectedRole.RoleName)..." -InformationAction Continue

            $ActivationParams = @{
                Action           = "selfActivate"
                PrincipalId      = $selectedRole.PrincipalId
                RoleDefinitionId = $selectedRole.RoleDefinitionId
                DirectoryScopeId = $selectedRole.DirectoryScopeId
                Justification    = $Justification
                ScheduleInfo     = @{
                    StartDateTime = (Get-Date).ToString("o")
                    Expiration    = @{
                        Type     = "AfterDuration"
                        Duration = "PT$($Duration)H"
                    }
                }
            }
            # Have had to convert to json before, seems to be fixed with msgraph 27
            Write-Debug "Activation Params`n"
            Write-Debug $ActivationParams

            try {
                $ActivationResult = New-MgRoleManagementDirectoryRoleAssignmentScheduleRequest -BodyParameter $ActivationParams -ErrorAction Stop
                Write-Information -MessageData "$($selectedRole.RoleName): $($ActivationResult.Status)" -InformationAction Continue
                # Calculate expiry
                $ExpiryDate = $ActivationResult.CreatedDateTime.AddMinutes( (Get-TimeZone).BaseUTcOffset.TotalMinutes + ( $Duration * 60 ) )
                Write-Information -MessageData "Expires: $ExpiryDate" -InformationAction Continue
            } catch {
                Write-Error "Unable to activate role: $($selectedRole.RoleName)"
                Write-Error $_.Exception.Message
            }

        }
    }

    END {
        Disconnect-MgGraph | Out-Null
        Write-Information -MessageData "`nDisconnected from MS Graph.`n" -InformationAction Continue
    }

}