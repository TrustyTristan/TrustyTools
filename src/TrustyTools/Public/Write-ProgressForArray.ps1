
<#
.SYNOPSIS
    Write out the progress for the processing of an array
.DESCRIPTION
    Allows you to quickly use Write-Progress in the shell.
.EXAMPLE
    Get total execution time
    C:\PS> Write-ProgressForArray -Array 'mail@box.com','box@mail.com' -Command {Set-Mailbox -HiddenFromAddressListsEnabled $true}
.EXAMPLE
    Define the input array
    C:\PS> $Array = @('user1','user2','user3')
    Define the command to be executed on each object in the array
    C:\PS> $Command = {Get-AdUser -Properties Manager -OutVariable a | %{$m = Get-Aduser $_.Manager;if($m){Write-Host $a.GivenName $a.Surname "REPORTS TO" $m.GivenName $m.Surname}} | Out-Host}
    C:\PS> Write-ProgressForArray -Array $Array -Command $Command
.EXAMPLE
    Get total execution time
    C:\PS> Write-ProgressForArray -Array $Array -Command $Command -InformationAction Continue
    Executed in: 0 Hours 4 Minutes 3 Seconds 446 Milliseconds
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
        $ProcessDuration = Measure-Command -Expression {
            for ($i = 0; $i -lt $ItemCount; $i++) {
                $PercentComplete = ($i + 1) / $ItemCount * 100
                Write-Progress -Activity $Activity -Status "$i/${ItemCount}: $($Array[$i])" -PercentComplete $PercentComplete
                $ObjectType = $Array[$i].GetType()
                if ($ObjectType.Name -eq 'String') {
                    "$($Array[$i])" | Invoke-Command -Command $Command
                } else {
                    $Array[$i] | Invoke-Command -Command $Command
                }
            }
        }
    }

    END {
        Write-Information "Executed in: $($ProcessDuration.Hours) Hours $($ProcessDuration.Minutes) Minutes $($ProcessDuration.Seconds) Seconds $($ProcessDuration.Milliseconds) Milliseconds"
    }

}