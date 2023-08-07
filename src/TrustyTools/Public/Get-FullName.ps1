<#
.SYNOPSIS
    Returns the concatenated GivenName and Surname
.DESCRIPTION
    Joins GivenName and Surname together, used a fair bit for reports and such.
.EXAMPLE
    PS> Get-FullName $ADUserObject
    John Doe
.PARAMETER InputObject
    Specifies the object to be processed.  You can also pipe the objects to this command.
.OUTPUTS
    System.String
.COMPONENT
    TrustyTools
#>
function Get-FullName {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
            ValueFromPipeline = $true,
            HelpMessage = 'Please pass AD User object')]
        [ValidateNotNullOrEmpty()]
        [object]$Identity
    )

    PROCESS {
        if ($Identity.GivenName) {
            $GivenName = $Identity.GivenName.Trim()
        }
        if ($Identity.Surname) {
            $Surname   = $Identity.Surname.Trim()
        }
        return ConvertTo-Case -String ("$($GivenName) $($Surname)".Trim()) -Type StartCase
    }

}