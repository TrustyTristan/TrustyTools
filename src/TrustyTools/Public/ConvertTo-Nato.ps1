<#
.SYNOPSIS
    Converts string to NATO phonetic alphabet
.DESCRIPTION
    Converts a string to the NATO phonetic alphabet. Handy for reading out passwords or serials
.EXAMPLE
    PS> ConvertTo-Nato "sHb8&d"
    Sierra,  capital-Hotel,  Bravo,  Eight,  Ampersand,  Delta
.PARAMETER String
    Specifies the string to be processed. You can also pipe the objects to this command.
.OUTPUTS
    System.String
.COMPONENT
    TrustyTools
#>
function ConvertTo-Nato {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
            ValueFromPipeline = $true,
            HelpMessage = 'Input must be a string')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$String
    )

    BEGIN {
        $NATOarray = @()
        $NATOalphabet = @{
            'a' = 'Alfa'
            'b' = 'Bravo'
            'c' = 'Charlie'
            'd' = 'Delta'
            'e' = 'Echo'
            'f' = 'Foxtrot'
            'g' = 'Golf'
            'h' = 'Hotel'
            'i' = 'India'
            'j' = 'Juliett'
            'k' = 'Kilo'
            'l' = 'Lima'
            'm' = 'Mike'
            'n' = 'November'
            'o' = 'Oscar'
            'p' = 'Papa'
            'q' = 'Quebec'
            'r' = 'Romeo'
            's' = 'Sierra'
            't' = 'Tango'
            'u' = 'Uniform'
            'v' = 'Victor'
            'w' = 'Whiskey'
            'x' = 'X-ray'
            'y' = 'Yankee'
            'z' = 'Zulu'
            '0' = 'Zero'
            '1' = 'One'
            '2' = 'Two'
            '3' = 'Three'
            '4' = 'Four'
            '5' = 'Five'
            '6' = 'Six'
            '7' = 'Seven'
            '8' = 'Eight'
            '9' = 'Nine'
            ' ' = 'Space'
            '!' = 'Exclamation'
            '"' = 'Double quote'
            '#' = 'Hash'
            '$' = 'Dollar sign'
            '%' = 'Percent'
            '&' = 'Ampersand'
            "'" = 'Single quote'
            '(' = 'Left parenthesis'
            ')' = 'Right parenthesis'
            '*' = 'Asterisk'
            '+' = 'Plus'
            ',' = 'Comma'
            '-' = 'Minus'
            '.' = 'Full stop'
            '/' = 'Slash'
            ':' = 'Colon'
            ';' = 'Semicolon'
            '<' = 'Less than'
            '=' = 'Equal sign'
            '>' = 'Greater than'
            '?' = 'Question mark'
            '@' = 'At sign'
            '[' = 'Left bracket'
            '\' = 'Backslash'
            ']' = 'Right bracket'
            '^' = 'Caret'
            '_' = 'Underscore'
            '`' = 'Backtick'
            '{' = 'Left brace'
            '|' = 'Vertical bar'
            '}' = 'Right brace'
            '~' = 'Tilde'
        }
    }

    PROCESS {
        foreach ($char in $String.ToCharArray()) {
            if ($char -cmatch '[A-Z]') {
                $NATOarray += 'capital-' + $NATOalphabet["$Char"]
            } else {
                $NATOarray += $NATOalphabet["$Char"]
            }
        }
    }

    END {
        if ( $NATOarray -gt 1 ) {
            return ($NATOarray -join ',  ')
        } else {
            return $NATOarray
        }
    }

}