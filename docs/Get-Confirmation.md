---
external help file: TrustyTools-help.xml
Module Name: TrustyTools
online version:
schema: 2.0.0
---

# Get-Confirmation

## SYNOPSIS
Prompt for confirmation

## SYNTAX

```
Get-Confirmation [[-Title] <String>] [[-Message] <String>] [[-YesHelp] <String>] [[-NoHelp] <String>]
 [[-Default] <String>] [<CommonParameters>]
```

## DESCRIPTION
Function to prompt for user confirmation before proceding.

## EXAMPLES

### EXAMPLE 1
```
Get-Confirmation -Title "Create Mailbox" -Message "Are you sure you want to create with these details"
```

Create Mailbox
Are you sure you want to create with these details
\[Y\] Yes  \[N\] No  \[?\] Help (default is "Y"):

### EXAMPLE 2
```
Get-Confirmation -Title "Delete Mailbox" -Message "Are you sure you want to delete `'$MailboxVar`'?" -Default No
```

Delete Mailbox
Are you sure you want to delete 'my@mailbox.var'?
\[Y\] Yes  \[N\] No  \[?\] Help (default is "N"):

## PARAMETERS

### -Title
Specifies the action that will be performed

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Message
Specifies the question about what will be performed'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: Do you want to continue?
Accept pipeline input: False
Accept wildcard characters: False
```

### -YesHelp
Specifies the Help message for Yes action

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: Proceeds with action
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoHelp
Specifies the Help message for No action

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: Skips the action
Accept pipeline input: False
Accept wildcard characters: False
```

### -Default
Specifies the default action.
(Default is yes)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: Yes
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Boolean
## NOTES

## RELATED LINKS
