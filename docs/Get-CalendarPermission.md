---
external help file: TrustyTools-help.xml
Module Name: TrustyTools
online version:
schema: 2.0.0
---

# Get-CalendarPermission

## SYNOPSIS
Get both the calendar folder permissions and if the user is in the book in policy

## SYNTAX

```
Get-CalendarPermission [-Identity] <String> [<CommonParameters>]
```

## DESCRIPTION
Get both the calendar folder permissions and if the user is in the book in policy

## EXAMPLES

### EXAMPLE 1
```
Get-CalendarPermissions -Identity Trusty@trusty.co
```

DisplayName      Alias     Permission     Bookin
-----------      -----     ----------     ------
Trusty Tristan   trusty    LimitedDetails True

## PARAMETERS

### -Identity
Specifies a mailbox identity

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

## RELATED LINKS
