---
external help file: TrustyTools-help.xml
Module Name: TrustyTools
online version:
schema: 2.0.0
---

# Get-NameFromCN

## SYNOPSIS
Returns the name and CN

## SYNTAX

```
Get-NameFromCN [-CN] <Array> [<CommonParameters>]
```

## DESCRIPTION
Because it is much faster to get groups via the MemberOf attribute object, this will translate the group name to an easy to read version.

## EXAMPLES

### EXAMPLE 1
```
Get-NameFromCN 'CN=GroupName,OU=Groups,DC=some,DC=domain,DC=name'
```

Name                           Value
----                           -----
GroupName                      CN=GroupName,OU=Groups,DC=some,DC=domain,DC=name

## PARAMETERS

### -CN
Specifies the CN or canonicalName to be processed. 
You can also pipe the objects to this command.

```yaml
Type: Array
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Collections.Specialized.OrderedDictionary
## NOTES

## RELATED LINKS
