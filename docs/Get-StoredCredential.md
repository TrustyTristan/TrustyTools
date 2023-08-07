---
external help file: TrustyTools-help.xml
Module Name: TrustyTools
online version:
schema: 2.0.0
---

# Get-StoredCredential

## SYNOPSIS
Gets stored credential

## SYNTAX

```
Get-StoredCredential [[-UserName] <String>] [[-Path] <FileInfo>] [<CommonParameters>]
```

## DESCRIPTION
Gets the stored .cred file created by New-StoredCredential

## EXAMPLES

### EXAMPLE 1
```
Get-StoredCredential -UserName trusty@trusty.domain
```

UserName                                 Password
--------                                 --------
trusty@trusty.domain System.Security.SecureString

## PARAMETERS

### -UserName
Please incldude the domain if required

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
Please a system file path

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Management.Automation.PSCredential
## NOTES

## RELATED LINKS
