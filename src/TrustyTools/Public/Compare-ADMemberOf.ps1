<#
.SYNOPSIS
    Compares the groups that 2 AD objects are members of
.DESCRIPTION
    Compares the output of Get-ADMemberOf to help quickly identify which groups are missing from a user.
.EXAMPLE
    PS> Compare-ADMemberOf -ReferenceObject user1 -DifferenceObject user2

    user1                   Diff user2
    -------------           ---- --------
    AC_Generic_Group        ==   AC_Generic_Group
                            =>   AC_Group_This__Other_Guy_Has
    AC_Group_This_Guy_Has   <=
.EXAMPLE
    PS> Compare-ADMemberOf -ReferenceObject assettag1$ -DifferenceObject assettag2$

    assettag1$             Diff assettag2$
    -------------          ---- --------
    AC_Generic_Group       ==   AC_Generic_Group
                           =>   AC_Group_This__Other_PC_Has
    AC_Group_This_PC_Has   <=
.PARAMETER ReferenceObject
    Specifies an Active Directory object to be compared against the DifferenceObject by providing the samAccountName of the object.
.PARAMETER DifferenceObject
    Specifies an Active Directory object to be compared against the ReferenceObject by providing the samAccountName of the object.
.OUTPUTS
    System.Management.Automation.PSCustomObject
.COMPONENT
    TrustyTools
    Requires: Get-ADMemberOf
    Requires: Get-NameFromCN
#>
function Compare-ADMemberOf {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
            HelpMessage = 'Please specify the samAccountName, if a computer object remember to append $')]
        [ValidateNotNullOrEmpty()]
        [string]$ReferenceObject,

        [Parameter(Mandatory = $true,
            HelpMessage = 'Please specify the samAccountName, if a computer object remember to append $')]
        [ValidateNotNullOrEmpty()]
        [string]$DifferenceObject
    )

    BEGIN {
        $ReferenceObjectGroups  = Get-AdMemberOf $ReferenceObject
        $DifferenceObjectGroups = Get-AdMemberOf $DifferenceObject
        $Comparison = New-Object System.Collections.Generic.List[System.Object]
    }

    PROCESS {
        if ( $ReferenceObjectGroups.Keys -and $DifferenceObjectGroups.Keys ) {
            Compare-Object -ReferenceObject $ReferenceObjectGroups.Keys -DifferenceObject $DifferenceObjectGroups.Keys -IncludeEqual |
                ForEach-Object {
                    if ($_.SideIndicator -eq '=>') {
                        $Comparison.Add(
                            [PSCustomObject]@{
                                $ReferenceObject  = '';
                                Diff              = $_.SideIndicator;
                                $DifferenceObject = $_.InputObject
                            }
                        )
                    } elseif ($_.SideIndicator -eq '<=') {
                        $Comparison.Add(
                            [PSCustomObject]@{
                                $ReferenceObject  = $_.InputObject;
                                Diff              = $_.SideIndicator;
                                $DifferenceObject = '';
                            }
                        )
                    } elseif ($_.SideIndicator -eq '==') {
                        $Comparison.Add(
                            [PSCustomObject]@{
                                $ReferenceObject  = $_.InputObject;
                                Diff              = $_.SideIndicator;
                                $DifferenceObject = $_.InputObject;
                            }
                        )
                    }
                }
        } elseif ( $ReferenceObjectGroups.Keys ) {
            $ReferenceObjectGroups.Keys |
                ForEach-Object {
                    $Comparison.Add(
                        [PSCustomObject]@{
                            $ReferenceObject  = $_;
                            Diff              = '<=';
                            $DifferenceObject = '';
                        }
                    )
                }
        } elseif ( $DifferenceObjectGroups.Keys ) {
            $DifferenceObjectGroups.Keys |
                ForEach-Object {
                    $Comparison.Add(
                        [PSCustomObject]@{
                            $ReferenceObject  = '';
                            Diff              = '=>';
                            $DifferenceObject = $_;
                        }
                    )
                }
        } else {
            $Comparison.Add(
                [PSCustomObject]@{
                    $ReferenceObject  = '';
                    Diff              = '';
                    $DifferenceObject = '';
                }
            )
        }
    }

    END {
        return $Comparison
    }

}