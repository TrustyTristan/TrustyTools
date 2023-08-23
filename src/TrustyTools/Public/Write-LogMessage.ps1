
<#
.SYNOPSIS
    Writes log message to file and host
.DESCRIPTION
    Allows you to quickly use Write-Progress in the shell.
.EXAMPLE
    C:\PS> Write-LogMessage -Path '.\path\for\log.log' -Message 'Useful message' -Component 'Install' -Type 'Info'
.EXAMPLE
    C:\PS> Write-LogMessage -Path '.\path\for\log.log' -Message 'Useful message' -Component 'Install' -Type 'Info' -Simple
.PARAMETER Message
    Specifies the log message
.PARAMETER Path
    Specifies the file path for the log file
.PARAMETER Component
    Specifies the component for the log message
.PARAMETER Type
    Specifies the type of log message, info, warning or error
.PARAMETER Simple
    Changes log format to more simple unix format
.NOTES
    Credit: https://janikvonrotz.ch/2017/10/26/powershell-logging-in-cmtrace-format/
.COMPONENT
    TrustyTools
#>

function Write-LogMessage {

    [CmdletBinding()]
    param (
        [parameter(Mandatory = $true,
            ValueFromPipeline = $true,
            HelpMessage = 'Message to write to log')]
        [string]$Message,

        [Parameter(Mandatory = $true,
            HelpMessage = 'Please enter a file path')]
        [System.IO.FileInfo]$Path,

        [parameter(Mandatory = $true,
            HelpMessage = 'Component that the message is related to')]
        [string]$Component,

        [Parameter(Mandatory = $true,
            HelpMessage = 'Log type')]
        [ValidateSet("Info", "Warning", "Error")]
        [string]$Type,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Change to simple non xml logging')]
        [switch]$Simple
    )

    PROCESS {

        # Write to host
        switch ($Type) {
            "Info" { Write-Information -MessageData $Message -InformationAction Continue }
            "Warning" { Write-Warning -Message $Message -WarningAction Continue }
            "Error" { Write-Error -Message $Message -ErrorAction Continue }
        }

        if ( -not $Simple ) {
            switch ($Type) {
                "Info" { [int]$Type = 1 }
                "Warning" { [int]$Type = 2 }
                "Error" { [int]$Type = 3 }
            }
            $Content = "<![LOG[$Message]LOG]!>" + `
                "<time=`"$(Get-Date -Format "HH:mm:ss.ffffff")`" " + `
                "date=`"$(Get-Date -Format "yyyy-MM-dd")`" " + `
                "component=`"$Component`" " + `
                "context=`"$([System.Security.Principal.WindowsIdentity]::GetCurrent().Name)`" " + `
                "type=`"$Type`" " + `
                "thread=`"$([Threading.Thread]::CurrentThread.ManagedThreadId)`" " + `
                "file=`"`">"
        } else {
            $Content = "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") ${Component}: $(if ($Type -ne "Info"){"$($Type.ToUpper()) "})$Message"
        }

        # Write the line to the log file
        try {
            Add-Content -Path $Path -Value $Content -ErrorAction Stop
        } catch {
            try {
                New-Item -Path $Path -Value $Content -ErrorAction Stop
            } catch {
                throw "Could not write log"
            }
        }
    }
}