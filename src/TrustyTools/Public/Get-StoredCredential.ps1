<#
.SYNOPSIS
    Gets stored credential
.DESCRIPTION
    Gets the stored .cred file created by New-StoredCredential
.EXAMPLE
    PS> Get-StoredCredential -UserName trusty@trusty.domain

    UserName                                 Password
    --------                                 --------
    trusty@trusty.domain System.Security.SecureString
.PARAMETER String
    Specifies the string to be processed. You can also pipe the objects to this command.
.OUTPUTS
    System.Management.Automation.PSCredential
.COMPONENT
    TrustyTools
#>
function Get-StoredCredential {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false,
            HelpMessage = 'Please incldude the domain if required')]
        [ValidateNotNullOrEmpty()]
        [string]$UserName = (whoami),

        [Parameter(Mandatory = $false,
            HelpMessage = 'Please a system file path')]
        [ValidateNotNullOrEmpty()]
        [System.IO.FileInfo]$Path = (Join-Path -Path (Split-Path $Profile) -ChildPath "credentials")
    )

    BEGIN {
        $StoredCredentials = Get-ChildItem -Path $Path -Filter *.cred
        $FileName = $UserName -split '\\'
        if ( $FileName.Count -eq 2 ) {
            $Domain   = $FileName[0]
            $UserName = $FileName[1]
            $FileName = "($Domain)$UserName"
        }
        $Credential = $null
    }

    PROCESS {
        $StoredCredential = $StoredCredentials | Where-Object BaseName -EQ $FileName
        if ( $StoredCredential ) {
            $CredentialContent = Get-Content $StoredCredential.FullName
            $UserName = $CredentialContent[0]
            $PwdSecureString = $CredentialContent[1] | ConvertTo-SecureString
            if ( $UserName -and $PwdSecureString ) {
                $Credential = New-Object System.Management.Automation.PSCredential -ArgumentList $UserName, $PwdSecureString
            } else {
                Write-Error "Could not retrieve credentials from `'$StoredCredential`'"
            }
        } else {
            Write-Error "Could not find credentials for `'$UserName`'"
        }
    }

    END {
        return $Credential
    }
}