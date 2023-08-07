<#
.SYNOPSIS
    Returns the name and CN
.DESCRIPTION
    Because it is much faster to get groups via the MemberOf attribute object, this will translate the group name to an easy to read version.
.EXAMPLE
    PS> Get-NameFromCN 'CN=GroupName,OU=Groups,DC=some,DC=domain,DC=name'

    Name                           Value
    ----                           -----
    GroupName                      CN=GroupName,OU=Groups,DC=some,DC=domain,DC=name
.PARAMETER CN
    Specifies the CN or canonicalName to be processed.  You can also pipe the objects to this command.
.OUTPUTS
    System.Collections.Specialized.OrderedDictionary
.COMPONENT
    TrustyTools
#>
function Get-NameFromCN {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
            ValueFromPipeline = $true,
            HelpMessage = 'Helpful Message')]
        [ValidateNotNullOrEmpty()]
        [array]$CN
    )

    BEGIN {
        # Match: GroupName
        # From: CN=GroupName,OU=Groups,DC=some,DC=domain,DC=name
        $RegexPattern = '(?<=^CN=)(.*?)(?=,)'
        $ConvertedCN = [ordered]@{}
    }

    PROCESS {
        $CN | ForEach-Object {
            $ConvertedCN.Add( [regex]::match($_,$RegexPattern).value, $_ )
        }
    }

    END {
        return $ConvertedCN | Sort-Object -Property Name
    }

}