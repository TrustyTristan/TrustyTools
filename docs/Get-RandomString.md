---
external help file: TrustyTools-help.xml
Module Name: TrustyTools
online version:
schema: 2.0.0
---

# Get-RandomString

## SYNOPSIS
Gets a random string

## SYNTAX

```
Get-RandomString [[-Length] <Int32>] [[-Exclude] <String[]>] [[-Disable] <String[]>] [<CommonParameters>]
```

## DESCRIPTION
Generates a random string, useful for passwords, keys etc.

## EXAMPLES

### EXAMPLE 1
```
Get-RandomString
2GMa$peO)kVS?l_+
```

### EXAMPLE 2
```
Get-RandomString -Length 32 -Disable Special
pIvhm5ZEjBeyDnck68bXUF4fgzS0NowG
```

### EXAMPLE 3
```
Get-RandomString -Length 32 -Disable Special, Lower, Digits
DJFKZEATWQXMOSVNYPLRCGUBHI
```

### EXAMPLE 4
```
Get-RandomString -Length 32 -Disable Special -Exclude 'I','l','O','0'
z9K2mqMLG3UDNxo6VfRY7pZvBtecPbAy
```

### EXAMPLE 5
```
Get-RandomString -Length 32 -Exclude:$false
MnV+B_(O)I{.z}'35*mdGHsW<":8p%!>
```

## PARAMETERS

### -Length
Specifies the number of characters for the string

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: 16
Accept pipeline input: False
Accept wildcard characters: False
```

### -Exclude
Specifies the characters to exclude from the string, by default the following are disabled: \`"'\/:;|\>\<,

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: @('`','"',"'",'\','/',':',';','|','>','<',',')
Accept pipeline input: False
Accept wildcard characters: False
```

### -Disable
Specifies the character types to exclude from the string

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
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
Int limit

## RELATED LINKS
