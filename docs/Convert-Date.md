---
external help file: TrustyTools-help.xml
Module Name: TrustyTools
online version:
schema: 2.0.0
---

# Convert-Date

## SYNOPSIS
Converts date/timestamp to clean format

## SYNTAX

```
Convert-Date [-InputDate] <String[]> [-Format <String>] [<CommonParameters>]
```

## DESCRIPTION
Converts date/timestamp to clean format, will return empty result if date is effectively null or obviously not real.
Can accept unix timestamp for those using 5.2 or older.

## EXAMPLES

### EXAMPLE 1
```
Convert-Date -InputDate '2023/07/17 10:43' -Format 'yyyyMMdd'
20230717
```

### EXAMPLE 2
```
Convert-Date -InputDate 1689590580 -Format 'yyyy/MM/dd hh:mm'
2023/07/17 10:43
```

## PARAMETERS

### -InputDate
Helpful Message

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Format
Specifies output format

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Yyyy/MM/dd
Accept pipeline input: False
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
