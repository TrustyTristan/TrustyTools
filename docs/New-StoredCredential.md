---
external help file: TrustyTools-help.xml
Module Name: TrustyTools
online version:
schema: 2.0.0
---

# New-StoredCredential

## SYNOPSIS
Saves credential as .cred

## SYNTAX

```
New-StoredCredential [[-UserName] <String>] [[-Path] <FileInfo>] [-Force] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Use to save PowerShell credentials to file.
By default it will use the current user and the current users PowerShell config path.

## EXAMPLES

### EXAMPLE 1
```
New-StoredCredential -UserName "trusty"
PowerShell credential request
Please enter password
Password for user trusty: ********
```


Credentials saved to '/user/.config/powershell/credentials/trusty.cred'

## PARAMETERS

### -UserName
Specifies the UserName

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: (whoami)
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
Specifies the file path
Default is: ~\User\.config\powershell\credentials

```yaml
Type: FileInfo
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: (Join-Path -Path (Split-Path $Profile) -ChildPath "credentials")
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Overwrites the existing file

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

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
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

