<#
.SYNOPSIS
    Gets Local Admin password.
.DESCRIPTION
    Gets Local Admin password.
.EXAMPLE
    Get-LocalAdmin TRUSTY69420
    Returns the Local Admin password for the computer.
.PARAMETER Identity
    Specifies an Active Directory computer
.PARAMETER Server
    Specifies the Active Directory Domain Services instance to connect to, by providing one of the following values for a corresponding domain name or directory server. The service
may be any of the following:  Active Directory Lightweight Domain Services, Active Directory Domain Services or Active Directory Snapshot instance.
#>
function Get-LAPS {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true,
            HelpMessage = 'Specify a computer object name')]
        [ValidateNotNullOrEmpty()]
        [string]$Computer,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Specify a domain or domain controller')]
        [ValidateNotNullOrEmpty()]
        [string]$Server = $env:USERDNSDOMAIN
    )

    BEGIN {
        try {
            $ComputerObject = Get-ADComputer -Identity $Computer -Properties ms-Mcs-AdmPwd -Server $Server
        } catch {
            Write-Error "Could not find `'$Computer`' on `'$Server`'"
        }
    }

    PROCESS {
        if ( $ComputerObject ) {
            $ComputerObject.'ms-Mcs-AdmPwd'.Trim() | Set-Clipboard
            return [PSCustomObject]@{
                Name      = $Computer
                Passsword = $ComputerObject.'ms-Mcs-AdmPwd'.Trim()
            }
        }
    }

}