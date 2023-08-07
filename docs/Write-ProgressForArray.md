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
Define the input array
$Array = 1, 2, 3, 4, 5
Define the command to be executed on each object in the array
$Command = {
    param($Object)
    # Do something with $Object
    $command = {param($object);$manager = Get-ADUser $object -Properties Manager| %{if (![string]::IsNullOrEmpty($_.Manager)){Get-aduser $_.Manager -Properties GivenName, Surname}}|%{Write-Host "Manager for $object is: $($_.GivenName) $($_.Surname)"}}
}
Write-ProgressForArray -Array $Array -Command $Command
```

### EXAMPLE 2
```
Another example of how to use this cmdlet
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
