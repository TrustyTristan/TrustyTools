---
external help file: TrustyTools-help.xml
Module Name: TrustyTools
online version:
schema: 2.0.0
---

# Request-PIMActivation

## SYNOPSIS
Activates Entra ID PIM eligible roles for the signed-in user using Microsoft Graph API.

## SYNTAX

```
Request-PIMActivation [[-TenantId] <String>] [[-Roles] <Array>] [-Justification] <String> [[-Duration] <Int32>]
 [-All] [<CommonParameters>]
```

## DESCRIPTION
This PowerShell script allows selective or bulk activation of eligible Entra ID roles via Microsoft Graph.

## EXAMPLES

### EXAMPLE 1
```
Request-PIMActivation -Justification "To perform work in Intune"
As a user, you may run this to activate any particular eligible roles that's assigned to your account
```

### EXAMPLE 2
```
Request-PIMActivation -Justification "To perform work in Intune" -Roles "Intune Administrator" -Duration 3
Specify the role and duration
```

### EXAMPLE 3
```
Request-PIMActivation -Justification "To do all the work" -All
Activate all roles
```

## PARAMETERS

### -TenantId
Specifies the Tenant Id

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

### -Roles
Specifies the roles you want to activate

```yaml
Type: Array
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Justification
Provide a reason for the account elevation

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

### -Duration
Duration in hours for elevation.
(1-8)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 8
Accept pipeline input: False
Accept wildcard characters: False
```

### -All
Switch statment to activate all eligible roles

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
Inspiration: Sankara Narayanan M S
Link: https://github.com/SankaraHQ/PIM-AutoActivator

## RELATED LINKS
