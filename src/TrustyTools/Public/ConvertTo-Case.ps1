<#
.SYNOPSIS
    Converts the case of a string
.DESCRIPTION
    Use to change the case of a string.
.EXAMPLE
    PS> ConvertTo-Case "The quick brown fox jumps over the lazy dog" -Type StartCase
    The Quick Brown Fox Jumps Over The Lazy Dog
.EXAMPLE
    PS> ConvertTo-Case "The quick brown fox jumps over the lazy dog" -Type UpperCase
    THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG
.EXAMPLE
    PS> ConvertTo-Case "The quick brown fox jumps over the lazy dog" -Type LowerCase
    the quick brown fox jumps over the lazy dog
.EXAMPLE
    PS> ConvertTo-Case "The quick brown fox jumps over the lazy dog" -Type CamelCase
    the Quick Brown Fox Jumps Over The Lazy Dog
.EXAMPLE
    PS> ConvertTo-Case '"jump over the (moon)." the cat said, "meow."' -Type SentenceCase
    "Jump over the (Moon)." The cat said, "Meow."
.EXAMPLE
    PS> ConvertTo-Case "The quick brown fox jumps over the lazy dog" -Type CamelCase
    The qUIcK bRoWN Fox jUMpS oVeR tHe LaZY Dog
.PARAMETER String
    Specifies the string to be processed.  You can also pipe the objects to this command.
.PARAMETER Type
    Specifies the type of processing.
.OUTPUTS
    System.String
.COMPONENT
    TrustyTools
#>
function ConvertTo-Case {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
            Position = 0,
            ValueFromPipeline = $true,
            HelpMessage = 'Helpful Message')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [array]$String,

        [Parameter(Mandatory = $true,
            Position = 1,
            HelpMessage = 'Specify the case type')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('StartCase','UpperCase','LowerCase','CamelCase','SentenceCase','InsaneCase')]
        [string]$Type
    )

    BEGIN {
        function ConvertTo-StartCase {
            [CmdletBinding()]
            param (
                [Parameter(Mandatory = $true,
                    ValueFromPipeline = $true,
                    HelpMessage = 'Please pass string')]
                [string]$String
            )

            PROCESS {
                $StartCase = [System.Text.RegularExpressions.Regex]::Replace(
                    $String.ToLower(),
                    '(^|\"| ''|''''|\(|\[|\<|\{|\ |(?<=[.!?])\s*)(\p{Lu}|\p{Ll})',
                    {
                        param($match)
                        return $match.Value.ToUpper()
                    }
                )
                return $StartCase
            }
        }

        function ConvertTo-UpperCase {
            [CmdletBinding()]
            param (
                [Parameter(Mandatory = $true,
                    ValueFromPipeline = $true,
                    HelpMessage = 'Please pass string')]
                [string]$String
            )

            PROCESS {
                return $String.ToUpper()
            }
        }

        function ConvertTo-LowerCase {
            [CmdletBinding()]
            param (
                [Parameter(Mandatory = $true,
                    ValueFromPipeline = $true,
                    HelpMessage = 'Please pass string')]
                [string]$String
            )

            PROCESS {
                return $String.ToLower()
            }
        }

        function ConvertTo-SentenceCase {
            [CmdletBinding()]
            param (
                [Parameter(Mandatory = $true,
                    ValueFromPipeline = $true,
                    HelpMessage = 'Please pass string')]
                [string]$String
            )

            PROCESS {
                $SentenceCase = [System.Text.RegularExpressions.Regex]::Replace(
                    $String.ToLower(),
                    '(^|\." |\"| ''|''''|\(|\[|\<|\{|(?<=[.!?])\s*)(\p{Lu}|\p{Ll})',
                    {
                        param($match)
                        return $match.Value.ToUpper()
                    }
                )
                return $SentenceCase
            }
        }

        function ConvertTo-InsaneCase {
            [CmdletBinding()]
            param (
                [Parameter(Mandatory = $true,
                    ValueFromPipeline = $true,
                    HelpMessage = 'Please pass string')]
                [string]$String
            )

            BEGIN {
                $Insane = @(
                    @(0,1,0,1,0,1,0,1),
                    @(1,0,1,0,1,0,1,0),
                    @(1,0,1,0,0,1,0,1),
                    @(0,1,0,0,1,0,1,1)
                )
                $GetInsanity = Get-Random $Insane
            }

            PROCESS {
                $InsaneCase = New-Object System.Collections.Generic.List[System.Object]
                $Original = $String -split ''
                for ($i = 0; $i -lt $Original.Length; $i++) {
                    if ($GetInsanity[$i % 8]) {
                        $InsaneCase.Add( $Original[$i].ToUpper() )
                    } else {
                        $InsaneCase.Add( $Original[$i].ToLower() )
                    }
                }
                if ( $InsaneCase.Count -gt 1 ) {
                    return $InsaneCase -join ''
                } else {
                    return $InsaneCase
                }
            }

        }

        function ConvertTo-CamelCase {
            [CmdletBinding()]
            param (
                [Parameter(Mandatory = $true,
                    ValueFromPipeline = $true,
                    HelpMessage = 'Please pass string')]
                [string]$String
            )

            PROCESS {
                $CamelCase = [System.Text.RegularExpressions.Regex]::Replace(
                    (ConvertTo-StartCase $String),
                    '(^|\." |\"|''|\(|\[|\<|\{|(?<=[.!?])\s*)(\p{Lu}|\p{Ll})',
                    {
                        param($match)
                        return $match.Value.ToLower()
                    }
                )
                return $CamelCase
            }
        }
    }

    PROCESS {
        switch ($Type) {
            'StartCase' {
                $String | ConvertTo-StartCase
            }
            'UpperCase' {
                $String | ConvertTo-UpperCase
            }
            'LowerCase' {
                $String | ConvertTo-LowerCase
            }
            'SentenceCase' {
                $String | ConvertTo-SentenceCase
            }
            'InsaneCase' {
                $String | ConvertTo-InsaneCase
            }
            'CamelCase' {
                $String | ConvertTo-CamelCase
            }
        }
    }

}