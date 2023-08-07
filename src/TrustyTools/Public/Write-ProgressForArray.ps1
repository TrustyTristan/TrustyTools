
<#
.SYNOPSIS
    Write out the progress for the processing of an array
.DESCRIPTION
    Allows you to quickly use Write-Progress in the shell.
.EXAMPLE
    Define the input array
    $Array = 1, 2, 3, 4, 5
    Define the command to be executed on each object in the array
    $Command = {
        param($Object)
        # Do something with $Object
        $command = {param($object);$manager = Get-ADUser $object -Properties Manager| %{if (![string]::IsNullOrEmpty($_.Manager)){Get-aduser $_.Manager -Properties GivenName, Surname}}|%{Write-Host "Manager for $object is: $($_.GivenName) $($_.Surname)"}}
    }
    Write-ProgressForArray -Array $Array -Command $Command
.EXAMPLE
    C:\PS>
    Another example of how to use this cmdlet
.PARAMETER Array
    Specifies the array of items to be processed
.PARAMETER Command
    The command or 'function' that is to be executed
.PARAMETER Activity
    The activy name for Write-Progress
.NOTES
    This needs to be revised
.COMPONENT
    TrustyTools
#>
function Write-ProgressForArray {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
            ValueFromPipeline = $true,
            HelpMessage = 'Please pass an array')]
        [ValidateNotNullOrEmpty()]
        [object[]]$Array,

        [Parameter(Mandatory = $true,
            HelpMessage = 'Expression is required')]
        [ValidateNotNullOrEmpty()]
        [scriptblock]$Command,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Specifies the first line of text in the heading above the status bar. This text describes the activity whose progress is being reported.')]
        [ValidateNotNullOrEmpty()]
        [string]$Activity
    )

    BEGIN {
        $ItemCount = $Array.Count
        if ( -not $Activity ) {
            $Activity = [string]$Command
        }
    }

    PROCESS {
        $processDuration = Measure-Command -Expression {
            for ($i = 0; $i -lt $ItemCount; $i++) {
                $percentComplete = ($i + 1) / $ItemCount * 100
                Write-Progress -Activity $Activity -Status "Processing: $($Array[$i]), $i of $ItemCount" -PercentComplete $percentComplete
                & $Command $Array[$i]
            }
        }
    }

    END {
        Write-Information "Executed in: $($processDuration.Hours) Hours $($processDuration.Minutes) Minutes $($processDuration.Seconds) Seconds $($processDuration.Milliseconds) Milliseconds"
    }

}