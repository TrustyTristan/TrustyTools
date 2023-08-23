---
external help file: TrustyTools-help.xml
Module Name: TrustyTools
online version:
schema: 2.0.0
---

# Write-LogMessage

## SYNOPSIS
Writes log message to file and host

## SYNTAX

```
Write-LogMessage [-Message] <String> [-Path] <FileInfo> [-Component] <String> [-Type] <String> [-Simple]
 [<CommonParameters>]
```

## DESCRIPTION
Allows you to quickly use Write-Progress in the shell.

## EXAMPLES

### EXAMPLE 1
```
Write-LogMessage -Path '.\path\for\log.log' -Message 'Useful message' -Component 'Install' -Type 'Info'
```

### EXAMPLE 2
```
Write-LogMessage -Path '.\path\for\log.log' -Message 'Useful message' -Component 'Install' -Type 'Info' -Simple
```

## PARAMETERS

### -Message
Specifies the log message

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

### -Path
Specifies the file path for the log file

```yaml
Type: FileInfo
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Component
Specifies the component for the log message

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Type
Specifies the type of log message, info, warning or error

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Simple
Changes log format to more simple unix format

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Credit: https://janikvonrotz.ch/2017/10/26/powershell-logging-in-cmtrace-format/

## RELATED LINKS
