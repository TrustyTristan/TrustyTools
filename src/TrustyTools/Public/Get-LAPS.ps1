<#
.SYNOPSIS
    Gets Local Admin password.
.DESCRIPTION
    Gets Local Admin password.
.EXAMPLE
    PS> Get-LocalAdmin TRUSTY69420
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
        [Parameter(Mandatory = $true,
            ValueFromPipeline = $true,
            HelpMessage = 'Specify a computer object name')]
        [ValidateNotNullOrEmpty()]
        [string[]]$Computer,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Specify a domain or domain controller')]
        [ValidateNotNullOrEmpty()]
        [string]$Server = $env:USERDNSDOMAIN
    )

    BEGIN {
        $LAPS = New-Object System.Collections.Generic.List[System.Object]
    }

    PROCESS {
        foreach ($ComputerName in $Computer) {
            try {
                $ComputerObject = Get-ADComputer -Identity $ComputerName -Properties 'ms-Mcs-AdmPwd' -Server $Server
                $LAPS.Add(
                    [PSCustomObject]@{
                        Name     = $ComputerObject.Name
                        Password = $ComputerObject.'ms-Mcs-AdmPwd'.Trim()
                    }
                )
            } catch {
                Write-Error "Could not find `'$ComputerName`' on `'$Server`'"
            }
        }
    }

    END {
        return $LAPS | Sort-Object Name
    }

}