---
external help file: TrustyTools-help.xml
Module Name: TrustyTools
online version:
schema: 2.0.0
---

# Get-FullName

## SYNOPSIS
Returns the concatenated GivenName and Surname

## SYNTAX

```
Get-FullName [-Identity] <Object> [<CommonParameters>]
```

## DESCRIPTION
Joins GivenName and Surname together, used a fair bit for reports and such.

## EXAMPLES

### EXAMPLE 1
```
Get-FullName $ADUserObject
John Doe
```

## PARAMETERS

### -Identity
Please pass AD User object

```yaml
Type: Object
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

### System.String
## NOTES

## RELATED LINKS
