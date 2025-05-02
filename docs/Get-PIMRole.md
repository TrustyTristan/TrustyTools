---
external help file: TrustyTools-help.xml
Module Name: TrustyTools
online version:
schema: 2.0.0
---

# Get-PIMRole

## SYNOPSIS
Gets all Entra ID PIM roles for the signed-in user using Microsoft Graph API.

## SYNTAX

```
Get-PIMRole [-TenantId] <String> [<CommonParameters>]
```

## DESCRIPTION
Stores eligible PIM roles in userprofile for use in "Request-PIMActivation"

## EXAMPLES

### EXAMPLE 1
```
Get-PIMRole -Tenant "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
Activate all roles
```

## PARAMETERS

### -TenantId
Specifies the Tenant Id

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Inspiration: Sankara Narayanan M S
Link: https://github.com/SankaraHQ/PIM-AutoActivator

## RELATED LINKS
