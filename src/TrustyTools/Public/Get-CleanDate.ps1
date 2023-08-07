<#
.SYNOPSIS
    Converts date/timestamp to clean format
.DESCRIPTION
    Converts date/timestamp to clean format, will return empty result if date is effectively null or obviously not real.
    Can accept unix timestamp for those using 5.2 or older.
.EXAMPLE
    Get-CleanDate -Timestamp '2023/07/17 10:43' -Format 'yyyyMMdd'
    20230717
.EXAMPLE
    Get-CleanDate -Timestamp 1689590580 -Format 'yyyy/MM/dd hh:mm'
    2023/07/17 10:43
.PARAMETER Timestamp
    Specifies the timestamp to be processed.
.PARAMETER Format
    Specifies output format
.OUTPUTS
    System.String
.COMPONENT
    TrustyTools
#>
# AWS's unknown date causes issues with Excel.. AD date format can vary for some reason.
function Get-CleanDate {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
            HelpMessage = 'Helpful Message')]
        [ValidateNotNullOrEmpty()]
        [string]$Timestamp,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Helpful Message')]
        [ValidateNotNullOrEmpty()]
        [string]$Format = 'yyyy/MM/dd'
    )

    BEGIN {
        $unixDate = Get-Date -Date "01/01/1970"
        $nullDates = @(
            '01/01/0001 00:00'
            '01/01/1901 00:00'
        )
    }

    PROCESS {
        if ( (-not [string]::IsNullOrEmpty($Timestamp)) -and ( $nullDates -notcontains $Timestamp ) ) {
            if ( $Timestamp -match '^\d{10}' ) {
                return Get-Date ( $unixDate + ([System.timeSpan]::FromSeconds( ("$Timestamp").substring(0,10) )) ) -Format $Format
            } else {
                return Get-Date $Timestamp -Format $Format
            }
        } else {
            return ''
        }
    }

}