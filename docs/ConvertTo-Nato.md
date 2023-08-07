---
external help file: TrustyTools-help.xml
Module Name: TrustyTools
online version:
schema: 2.0.0
---

# ConvertTo-Nato

## SYNOPSIS
Converts string to NATO phonetic alphabet

## SYNTAX

```
ConvertTo-Nato [-String] <String> [<CommonParameters>]
```

## DESCRIPTION
Converts a string to the NATO phonetic alphabet.
Handy for reading out passwords or serials

## EXAMPLES

### EXAMPLE 1
```
ConvertTo-Nato "sHb8&d"
Sierra,  capital-Hotel,  Bravo,  Eight,  Ampersand,  Delta
```

## PARAMETERS

### -String
Specifies the string to be processed.
You can also pipe the objects to this command.

```yaml
Type: String
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
