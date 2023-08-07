---
external help file: TrustyTools-help.xml
Module Name: TrustyTools
online version:
schema: 2.0.0
---

# Compare-ADMemberOf

## SYNOPSIS
Compares the groups that 2 AD objects are members of

## SYNTAX

```
Compare-ADMemberOf [-ReferenceObject] <String> [-DifferenceObject] <String> [<CommonParameters>]
```

## DESCRIPTION
Compares the output of Get-ADMemberOf to help quickly identify which groups are missing from a user.

## EXAMPLES

### EXAMPLE 1
```
Compare-ADMemberOf -ReferenceObject user1 -DifferenceObject user2
```

user1                   Diff user2
-------------           ---- --------
AC_Generic_Group        ==   AC_Generic_Group
                        =\>   AC_Group_This__Other_Guy_Has
AC_Group_This_Guy_Has   \<=

### EXAMPLE 2
```
Compare-ADMemberOf -ReferenceObject assettag1$ -DifferenceObject assettag2$
```

assettag1$             Diff assettag2$
-------------          ---- --------
AC_Generic_Group       ==   AC_Generic_Group
                       =\>   AC_Group_This__Other_PC_Has
AC_Group_This_PC_Has   \<=

## PARAMETERS

### -ReferenceObject
Specifies an Active Directory object to be compared against the DifferenceObject by providing the samAccountName of the object.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DifferenceObject
Specifies an Active Directory object to be compared against the ReferenceObject by providing the samAccountName of the object.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Management.Automation.PSCustomObject
## NOTES

## RELATED LINKS
