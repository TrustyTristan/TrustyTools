---
external help file: TrustyTools-help.xml
Module Name: TrustyTools
online version:
schema: 2.0.0
---

# New-DynamicParam

## SYNOPSIS
Helper function to simplify creating dynamic parameters

## SYNTAX

```
New-DynamicParam [[-Name] <String>] [[-Type] <Type>] [[-Alias] <String[]>] [[-ValidateSet] <String[]>]
 [-Mandatory] [[-ParameterSetName] <String>] [[-Position] <Int32>] [-ValueFromPipelineByPropertyName]
 [[-HelpMessage] <String>] [[-DPDictionary] <Object>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Helper function to simplify creating dynamic parameters

Example use cases:
    Include parameters only if your environment dictates it
    Include parameters depending on the value of a user-specified parameter
    Provide tab completion and intellisense for parameters, depending on the environment

Please keep in mind that all dynamic parameters you create will not have corresponding variables created.
    One of the examples illustrates a generic method for populating appropriate variables from dynamic parameters
    Alternatively, manually reference $PSBoundParameters for the dynamic parameter value

## EXAMPLES

### EXAMPLE 1
```
function Show-Free {
    [CmdletBinding()]
    Param()
    DynamicParam {
        $options = @( gwmi win32_volume | %{$_.driveletter} | sort )
        New-DynamicParam -Name Drive -ValidateSet $options -Position 0 -Mandatory
    }
    BEGIN {
        #have to manually populate
        $drive = $PSBoundParameters.drive
    }
    PROCESS {
        $vol = gwmi win32_volume -Filter "driveletter='$drive'"
        "{0:N2}% free on {1}" -f ($vol.Capacity / $vol.FreeSpace),$drive
    }
} #Show-Free
```

Show-Free -Drive \<tab\>

This example illustrates the use of New-DynamicParam to create a single dynamic parameter
The Drive parameter ValidateSet populates with all available volumes on the computer for handy tab completion / intellisense

### EXAMPLE 2
```
I found many cases where I needed to add more than one dynamic parameter
The DPDictionary parameter lets you specify an existing dictionary
The block of code in the Begin block loops through bound parameters and defines variables if they don't exist
```

Function Test-DynPar{
    \[cmdletbinding()\]
    param(
        \[string\[\]\]$x = $Null
    )
    DynamicParam {
        #Create the RuntimeDefinedParameterDictionary
        $Dictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary
        New-DynamicParam -Name AlwaysParam -ValidateSet @( gwmi win32_volume | %{$_.driveletter} | sort ) -DPDictionary $Dictionary
        #Add dynamic parameters to $dictionary
        if ($x -eq 1) {
            New-DynamicParam -Name X1Param1 -ValidateSet 1,2 -mandatory -DPDictionary $Dictionary
            New-DynamicParam -Name X1Param2 -DPDictionary $Dictionary
            New-DynamicParam -Name X3Param3 -DPDictionary $Dictionary -Type DateTime
        } else {
            New-DynamicParam -Name OtherParam1 -Mandatory -DPDictionary $Dictionary
            New-DynamicParam -Name OtherParam2 -DPDictionary $Dictionary
            New-DynamicParam -Name OtherParam3 -DPDictionary $Dictionary -Type DateTime
        }
        #return RuntimeDefinedParameterDictionary
        $Dictionary
    }
    BEGIN {
        #This standard block of code loops through bound parameters...
        #If no corresponding variable exists, one is created
            #Get common parameters, pick out bound parameters not in that set
            Function _temp { \[cmdletbinding()\] param() }
            $BoundKeys = $PSBoundParameters.keys | Where-Object { (get-command _temp | select -ExpandProperty parameters).Keys -notcontains $_}
            foreach($param in $BoundKeys) {
                if (-not ( Get-Variable -name $param -scope 0 -ErrorAction SilentlyContinue ) ) {
                    New-Variable -Name $Param -Value $PSBoundParameters.$param
                    Write-Verbose "Adding variable for dynamic parameter '$param' with value '$($PSBoundParameters.$param)'"
                }
            }

        #Appropriate variables should now be defined and accessible
            Get-Variable -scope 0
    }
}

This example illustrates the creation of many dynamic parameters using New-DynamicParam
You must create a RuntimeDefinedParameterDictionary object ($dictionary here)
To each New-DynamicParam call, add the -DPDictionary parameter pointing to this RuntimeDefinedParameterDictionary
At the end of the DynamicParam block, return the RuntimeDefinedParameterDictionary
Initialize all bound parameters using the provided block or similar code

## PARAMETERS

### -Name
Name of the dynamic parameter

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

### -Type
Type for the dynamic parameter. 
Default is string

```yaml
Type: Type
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: String
Accept pipeline input: False
Accept wildcard characters: False
```

### -Alias
If specified, one or more aliases to assign to the dynamic parameter

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: @()
Accept pipeline input: False
Accept wildcard characters: False
```

### -ValidateSet
If specified, set the ValidateSet attribute of this dynamic parameter

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Mandatory
If specified, set the Mandatory attribute for this dynamic parameter

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

### -ParameterSetName
If specified, set the ParameterSet attribute for this dynamic parameter

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: __AllParameterSets
Accept pipeline input: False
Accept wildcard characters: False
```

### -Position
If specified, set the Position attribute for this dynamic parameter

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -ValueFromPipelineByPropertyName
If specified, set the ValueFromPipelineByPropertyName attribute for this dynamic parameter

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

### -HelpMessage
If specified, set the HelpMessage for this dynamic parameter

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DPDictionary
If specified, add resulting RuntimeDefinedParameter to an existing RuntimeDefinedParameterDictionary (appropriate for multiple dynamic parameters)
If not specified, create and return a RuntimeDefinedParameterDictionary (appropriate for a single dynamic parameter)

See final example for illustration

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
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

## NOTES
Credit to http://jrich523.wordpress.com/2013/05/30/powershell-simple-way-to-add-dynamic-parameters-to-advanced-function/
    Added logic to make option set optional
    Added logic to add RuntimeDefinedParameter to existing DPDictionary
    Added a little comment based help

Credit to BM for alias and type parameters and their handling

## RELATED LINKS
