---
external help file: TrustyTools-help.xml
Module Name: TrustyTools
online version:
schema: 2.0.0
---

# ConvertTo-Case

## SYNOPSIS
Converts the case of a string

## SYNTAX

```
ConvertTo-Case [-String] <Array> [-Type] <String> [<CommonParameters>]
```

## DESCRIPTION
Use to change the case of a string.

## EXAMPLES

### EXAMPLE 1
```
ConvertTo-Case "The quick brown fox jumps over the lazy dog" -Type StartCase
The Quick Brown Fox Jumps Over The Lazy Dog
```

### EXAMPLE 2
```
ConvertTo-Case "The quick brown fox jumps over the lazy dog" -Type UpperCase
THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG
```

### EXAMPLE 3
```
ConvertTo-Case "The quick brown fox jumps over the lazy dog" -Type LowerCase
the quick brown fox jumps over the lazy dog
```

### EXAMPLE 4
```
ConvertTo-Case "The quick brown fox jumps over the lazy dog" -Type CamelCase
the Quick Brown Fox Jumps Over The Lazy Dog
```

### EXAMPLE 5
```
ConvertTo-Case '"jump over the (moon)." the cat said, "meow."' -Type SentenceCase
"Jump over the (Moon)." The cat said, "Meow."
```

### EXAMPLE 6
```
ConvertTo-Case "The quick brown fox jumps over the lazy dog" -Type CamelCase
The qUIcK bRoWN Fox jUMpS oVeR tHe LaZY Dog
```

## PARAMETERS

### -String
Specifies the string to be processed. 
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

### -Type
Specifies the type of processing.

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

### System.String
## NOTES

## RELATED LINKS
