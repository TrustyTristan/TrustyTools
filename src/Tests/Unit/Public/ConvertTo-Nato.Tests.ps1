#-------------------------------------------------------------------------
Set-Location -Path $PSScriptRoot
#-------------------------------------------------------------------------
$ModuleName = 'TrustyTools'
$PathToManifest = [System.IO.Path]::Combine('..', '..', '..', $ModuleName, "$ModuleName.psd1")
#-------------------------------------------------------------------------
if (Get-Module -Name $ModuleName -ErrorAction 'SilentlyContinue') {
    #if the module is already in memory, remove it
    Remove-Module -Name $ModuleName -Force
}
Import-Module $PathToManifest -Force
#-------------------------------------------------------------------------

InModuleScope 'TrustyTools' {
    Describe 'ConvertTo-Nato Public Function Tests' -Tag Unit {
        BeforeAll {
            $WarningPreference = 'SilentlyContinue'
            $ErrorActionPreference = 'SilentlyContinue'
        } #beforeAll
        Context 'Converting string to NATO Phonetic Alphabet' {
            It 'should return the expected results' {
                $result = ConvertTo-Nato 'abcdefghijklmnopqrstuvwxyz1234567890'
                $result | Should -BeExactly 'Alfa,  Bravo,  Charlie,  Delta,  Echo,  Foxtrot,  Golf,  Hotel,  India,  Juliett,  Kilo,  Lima,  Mike,  November,  Oscar,  Papa,  Quebec,  Romeo,  Sierra,  Tango,  Uniform,  Victor,  Whiskey,  X-ray,  Yankee,  Zulu,  One,  Two,  Three,  Four,  Five,  Six,  Seven,  Eight,  Nine,  Zero'
            }
        }

        Context 'Converts uppercase letters to NATO alphabet with ''capital-'' prefix' {
            It 'should return the expected results' {
                $result = ConvertTo-Nato 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
                $result | Should -BeExactly 'capital-Alfa,  capital-Bravo,  capital-Charlie,  capital-Delta,  capital-Echo,  capital-Foxtrot,  capital-Golf,  capital-Hotel,  capital-India,  capital-Juliett,  capital-Kilo,  capital-Lima,  capital-Mike,  capital-November,  capital-Oscar,  capital-Papa,  capital-Quebec,  capital-Romeo,  capital-Sierra,  capital-Tango,  capital-Uniform,  capital-Victor,  capital-Whiskey,  capital-X-ray,  capital-Yankee,  capital-Zulu'
            }
        }

        Context 'Converts special characters to NATO Phonetic' {
            It 'should return the expected results' {
                $result = ConvertTo-Nato "-/![]`^`"#=@|\%+ }.,(';):&_?$>{*~<"
                $result | Should -BeExactly 'Minus,  Slash,  Exclamation,  Left bracket,  Right bracket,  Caret,  Double quote,  Hash,  Equal sign,  At sign,  Vertical bar,  Backslash,  Percent,  Plus,  Space,  Right brace,  Full stop,  Comma,  Left parenthesis,  Single quote,  Semicolon,  Right parenthesis,  Colon,  Ampersand,  Underscore,  Question mark,  Dollar sign,  Greater than,  Left brace,  Asterisk,  Tilde,  Less than'
            }
        }

        Context 'Converts single character to NATO Phonetic' {
            It 'should return the expected results' {
                $result = ConvertTo-Nato "a"
                $result | Should -BeExactly 'Alfa'
            }
        }

        Context "Invalid input" {
            It "Throws an error for empty input" {
                { ConvertTo-Nato @() } | Should -Throw
            }

            It "Throws an error for null input" {
                { ConvertTo-Nato $null } | Should -Throw
            }
        }
    }
}