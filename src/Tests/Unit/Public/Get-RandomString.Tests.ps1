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
    Describe 'Get-RandomString Public Function Tests' -Tag Unit {
        BeforeAll {
            $WarningPreference = 'SilentlyContinue'
            $ErrorActionPreference = 'SilentlyContinue'
        } #beforeAll
        Context "Get-RandomString valid outputs" {
            It "should return expected string length" {
                $result = Get-RandomString -Length 128
                $result.Length | Should -BeExactly 128
            }
            It "should contain no digits" {
                $result = (Get-RandomString -Disable Digits)
                $result -match '\d' | Should -BeFalse
            }
            It "should contain no lower case" {
                $result = (Get-RandomString -Disable Lower)
                $result -cmatch '[a-z]' | Should -BeFalse
            }
            It "should contain no upper case" {
                $result = (Get-RandomString -Disable Upper)
                $result -cmatch '[A-Z]' | Should -BeFalse
            }
            It "should contain no special characters" {
                [string[]] $Specials = @('!','@','#','$','%','^','&','*','(',')','-','_','+','=','{','}','[',']','|','\',':',';','"',"'",'\','<','>',',','.','?','/','`')
                $output = (Get-RandomString -Disable Special)
                $result = $output.GetEnumerator() | Where-Object {$Specials -ccontains $_}
                $result | Should -BeNullOrEmpty
            }
            It "should contain none of the specified characters" {
                $output = (Get-RandomString -Exclude 'T','a' -Disable Digits, Special)
                $result = $output.GetEnumerator() | Where-Object {@('T','a') -ccontains $_}
                $result | Should -BeNullOrEmpty
            }
        }

        Context "Invalid input" {
            It "Throws an error for empty input" {
                { Get-RandomString @() } | Should -Throw
            }

            It "Throws an error for null input" {
                { Get-RandomString $null } | Should -Throw
            }
        }
    }
}