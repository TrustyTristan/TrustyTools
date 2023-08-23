<#
.SYNOPSIS
    Displays a list of the groups the object (User/Computer) is a member of.
.DESCRIPTION
    Long description
.EXAMPLE
    PS> Get-ADMemberOf trusty
    Displays all the groups the user is a member of.
.EXAMPLE
    PS> Get-ADMemberOf TRUSTY69420$
    Displays all the groups the user is a member of.
.PARAMETER Identity
    Specifies an Active Directory object by providing the samAccountName of the object. Computer objects have a $ appended to the end.
.PARAMETER Server
    Specifies the Active Directory Domain Services instance to connect to, by providing one of the following values for a corresponding domain name or directory server. The service
may be any of the following:  Active Directory Lightweight Domain Services, Active Directory Domain Services or Active Directory Snapshot instance.
.OUTPUTS
    System.Collections.Specialized.OrderedDictionary
.NOTES
    General notes
.COMPONENT
    TrustyTools
#>
function Get-ADMemberOf {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
            Position = 0,
            ValueFromPipeline = $true,
            HelpMessage = 'Specify a Active Directory object samAccountName. If the object is a computer append $')]
        [ValidateNotNullOrEmpty()]
        [string]$Identity,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Specify a Domain controller')]
        [ValidateNotNullOrEmpty()]
        [string]$Server = $env:USERDNSDOMAIN
    )

    PROCESS {
        if ( $Identity ) {
            $MemberOfResult = (Get-ADObject -Filter {samAccountName -eq $Identity} -Properties Memberof -Server $Server).Memberof
            if ( $MemberOfResult ) {
                return Get-NameFromCN $MemberOfResult
            }
        }
    }

}