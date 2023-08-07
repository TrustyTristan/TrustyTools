<#
.SYNOPSIS
    Gets a random string
.DESCRIPTION
    Generates a random string, useful for passwords, keys etc.
.EXAMPLE
    PS> Get-RandomString
    2GMa$peO)kVS?l_+
.EXAMPLE
    PS> Get-RandomString -Length 32 -Disable Special
    pIvhm5ZEjBeyDnck68bXUF4fgzS0NowG
.EXAMPLE
    PS> Get-RandomString -Length 32 -Disable Special, Lower, Digits
    DJFKZEATWQXMOSVNYPLRCGUBHI
.EXAMPLE
    PS> Get-RandomString -Length 32 -Disable Special -Exclude 'I','l','O','0'
    z9K2mqMLG3UDNxo6VfRY7pZvBtecPbAy
.EXAMPLE
    PS> Get-RandomString -Length 32 -Exclude:$false
    MnV+B_(O)I{.z}'35*mdGHsW<":8p%!>
.PARAMETER Length
    Specifies the number of characters for the string
.PARAMETER Exclude
    Specifies the characters to exclude from the string, by default the following are disabled: `"'\/:;|><,
.PARAMETER Disable
    Specifies the character types to exclude from the string
.OUTPUTS
    System.String
.NOTES
    Int limit
.COMPONENT
    TrustyTools
#>
function Get-RandomString {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false,
            HelpMessage = 'Input must be a number')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [int]$Length = 16,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Input must be a string')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string[]]$Exclude = @('`','"',"'",'\','/',':',';','|','>','<',','),

        [Parameter(Mandatory = $false)]
        [ValidateSet("Upper", "Lower", "Digits", "Special", "Letters")]
        [string[]]$Disable
    )

    BEGIN {
        [int[]] $Digits      = @(0..9)
        [string[]] $LLetters = @('a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z')
        [string[]] $ULetters = @('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z')
        [string[]] $Specials = @('!','@','#','$','%','^','&','*','(',')','-','_','+','=','{','}','[',']','|','\',':',';','"',"'",'\','<','>',',','.','?','/','`')
        switch ($Disable) {
            "Letters" {
                $LLetters = @()
                $ULetters = @()
            }
            "Upper" {
                $ULetters = @()
            }
            "Lower" {
                $LLetters = @()
            }
            "Digits" {
                $Digits   = @()
            }
            "Special" {
                $Specials = @()
            }
        }
    }

    PROCESS {
        $Characters = $LLetters + $ULetters + $Digits + $Specials
        $AllowedCharacters = Compare-Object -ReferenceObject $Characters -DifferenceObject $Exclude -CaseSensitive -PassThru |
            Where-Object {
                $_.SideIndicator -eq '<='
            }
        # Increase character count if required
        while ($AllowedCharacters.Length -lt $Length) {
            $AllowedCharacters += $AllowedCharacters
        }
        -join ( $AllowedCharacters | Get-Random -Count $Length )
    }

}