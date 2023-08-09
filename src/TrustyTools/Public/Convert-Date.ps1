<#
.SYNOPSIS
    Converts date/timestamp to clean format
.DESCRIPTION
    Converts date/timestamp to clean format, will return empty result if date is effectively null or obviously not real.
    Can accept unix timestamp for those using 5.2 or older.
.EXAMPLE
    Convert-Date -InputDate '2023/07/17 10:43' -Format 'yyyyMMdd'
    20230717
.EXAMPLE
    Convert-Date -InputDate 1689590580 -Format 'yyyy/MM/dd hh:mm'
    2023/07/17 10:43
.PARAMETER Input
    Specifies the timestamp to be processed.
.PARAMETER Format
    Specifies output format
.OUTPUTS
    System.String
.COMPONENT
    TrustyTools
#>
# AWS's unknown date causes issues with Excel.. AD date format can vary for some reason.
function Convert-Date {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
            HelpMessage = 'Helpful Message')]
        [ValidateNotNullOrEmpty()]
        [string]$InputDate,

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
        if ( (-not [string]::IsNullOrEmpty($InputDate)) -and ( $nullDates -notcontains $InputDate ) ) {
            if ( $InputDate -match '^\d{10}' ) {
                return Get-Date ( $unixDate + ([System.timeSpan]::FromSeconds( ("$InputDate").substring(0,10) )) ) -Format $Format
            } else {
                return Get-Date $InputDate -Format $Format
            }
        } else {
            return ''
        }
    }

}