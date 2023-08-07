---
external help file: TrustyTools-help.xml
Module Name: TrustyTools
online version:
schema: 2.0.0
---

# Get-CleanDate

## SYNOPSIS
Converts date/timestamp to clean format

## SYNTAX

```
Get-CleanDate [-Timestamp] <String> [[-Format] <String>] [<CommonParameters>]
```

## DESCRIPTION
Converts date/timestamp to clean format, will return empty result if date is effectively null or obviously not real.
Can accept unix timestamp for those using 5.2 or older.

## EXAMPLES

### EXAMPLE 1
```
Get-CleanDate -Timestamp '2023/07/17 10:43' -Format 'yyyyMMdd'
20230717
```

### EXAMPLE 2
```
Get-CleanDate -Timestamp 1689590580 -Format 'yyyy/MM/dd hh:mm'
2023/07/17 10:43
```

## PARAMETERS

### -Timestamp
Specifies the timestamp to be processed.

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

### -Format
Specifies output format

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
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
