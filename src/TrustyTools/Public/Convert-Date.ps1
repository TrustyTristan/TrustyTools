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
function Convert-Date {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
            Position = 0,
            ValueFromPipeline = $true,
            HelpMessage = 'Helpful Message')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({
                if ($_ -is [array] -and $_.Count -eq 0) {
                    throw "Array cannot be empty."
                }
                $true
            })]
        $InputDate,

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
        $regexMMddyyyy = '(?<month>\d{1,2})[-/](?<day>\d{1,2})[-/](?<year>\d{4})'
        $regexyyyyddMM = '(?<year>\d{4})[-/](?<day>\d{1,2})[-/](?<month>\d{1,2})'
        $regexddMMyyyy = '(?<day>\d{1,2})[-/](?<month>\d{1,2})[-/](?<year>\d{4})'
        $regexyyyyMMdd = '(?<year>\d{4})[-/](?<month>\d{1,2})[-/](?<day>\d{1,2})'

        function Get-RegexDate {
            param (
                [string]$InputDate
            )

            if ( ([cultureinfo]::CurrentCulture.DateTimeFormat.ShortDatePattern -split '/')[0] -eq 'd' ) {
                # Convert From Freedom Date
                if ($InputDate -match $regexMMddyyyy) {
                    $day = $matches.day
                    $month = $matches.month
                    $year = $matches.year
                    return $InputDate -replace $matches.0,"$year/$month/$day"
                } elseif ($DateString -match $regexyyyyddMM) {
                    $day = $matches.day
                    $month = $matches.month
                    $year = $matches.year
                    return $InputDate -replace $matches.0,"$year/$month/$day"
                }
            } elseif ( ([cultureinfo]::CurrentCulture.DateTimeFormat.ShortDatePattern -split '/')[0] -eq 'M' ) {
                # Convert From Australian Date
                if ($InputDate -match $regexddMMyyyy) {
                    $day = $matches.day
                    $month = $matches.month
                    $year = $matches.year
                    return $InputDate -replace $matches.0,"$year/$month/$day"
                } elseif ($DateString -match $regexyyyyMMdd) {
                    $day = $matches.day
                    $month = $matches.month
                    $year = $matches.year
                    return $InputDate -replace $matches.0,"$year/$month/$day"
                }
            }
        }
    }

    PROCESS {
        foreach ($DateString in $InputDate) {
            if ( (-not [string]::IsNullOrEmpty($DateString)) -and ( $nullDates -notcontains $DateString ) ) {
                if ( $InputDate.GetType().Name -eq 'DateTime' ) {
                    return Get-Date $InputDate -Format $Format -ErrorAction Stop
                } elseif ( $DateString -match '^\d{10}' ) {
                    return Get-Date ( $unixDate + ([System.timeSpan]::FromSeconds( ("$DateString").substring(0,10) )) ) -Format $Format
                } else {
                    try {
                        return Get-Date $DateString -Format $Format -ErrorAction Stop
                    } catch {
                        return Get-Date (Get-RegexDate $DateString) -Format $Format -ErrorAction Stop
                    }
                }
            }
        }
    }

}