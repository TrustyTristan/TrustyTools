---
external help file: TrustyTools-help.xml
Module Name: TrustyTools
online version:
schema: 2.0.0
---

# Write-ProgressForArray

## SYNOPSIS
Write out the progress for the processing of an array

## SYNTAX

```
Write-ProgressForArray [-Array] <Object[]> [-Command] <ScriptBlock> [[-Activity] <String>] [<CommonParameters>]
```

## DESCRIPTION
Allows you to quickly use Write-Progress in the shell.

## EXAMPLES

### EXAMPLE 1
```
Get total execution time
C:\PS> Write-ProgressForArray -Array 'mail@box.com','box@mail.com' -Command {Set-Mailbox -HiddenFromAddressListsEnabled $true}
```

### EXAMPLE 2
```
Define the input array
C:\PS> $Array = @('user1','user2','user3')
Define the command to be executed on each object in the array
C:\PS> $Command = {Get-AdUser -Properties Manager -OutVariable a | %{$m = Get-Aduser $_.Manager;if($m){Write-Host $a.GivenName $a.Surname "REPORTS TO" $m.GivenName $m.Surname}} | Out-Host}
C:\PS> Write-ProgressForArray -Array $Array -Command $Command
```

### EXAMPLE 3
```
Get total execution time
C:\PS> Write-ProgressForArray -Array $Array -Command $Command -InformationAction Continue
Executed in: 0 Hours 4 Minutes 3 Seconds 446 Milliseconds
```

## PARAMETERS

### -Array
Specifies the array of items to be processed

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Command
The command or 'function' that is to be executed

```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Activity
The activy name for Write-Progress

```yaml
Type: String
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

## NOTES
This needs to be revised

## RELATED LINKS
