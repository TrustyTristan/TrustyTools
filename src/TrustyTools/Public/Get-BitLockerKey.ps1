<#
.SYNOPSIS
    Gets the BitLocker keys
.DESCRIPTION
    Gets the BitLocker keys from the active directory store
.EXAMPLE
    PS> Get-BitLockerKey -Computer DESKTOP-69420
.PARAMETER Identity
    Specifies an Active Directory computer
.PARAMETER Server
    Specifies the Active Directory Domain Services instance to connect to, by providing one of the following values for a corresponding domain name or directory server. The service
may be any of the following:  Active Directory Lightweight Domain Services, Active Directory Domain Services or Active Directory Snapshot instance.
#>
function Get-BitLockerKey {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true,
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
        $BitLockerKeys = New-Object System.Collections.Generic.List[System.Object]
    }

    PROCESS {
        foreach ($ComputerName in $Computer) {
            try {
                $ComputerObject = Get-ADComputer -Identity $ComputerName -Server $Server -ErrorAction Stop
                $BitlockerObject = Get-ADObject -Filter {objectclass -eq 'msFVE-RecoveryInformation'} -Server $Server -SearchBase $ComputerObject.DistinguishedName -Properties 'msFVE-RecoveryPassword','Created'
                if ( $BitlockerObject ) {
                    $BitlockerObject | ForEach-Object {
                        $BitLockerKeys.Add(
                            [PSCustomObject]@{
                                Name = $ComputerObject.Name
                                Date = Convert-Date -InputDate $_.Created -Format 'yyyy/MM/dd hh:mm:ss tt'
                                Key  = $_.'msFVE-RecoveryPassword'.Trim()
                            }
                        )
                    }
                }
            } catch {
                Write-Error "Could not find `'$ComputerName`' on `'$Server`'"
            }
        }
    }

    END {
        return $BitLockerKeys | Sort-Object -Property Date -Descending
    }

}