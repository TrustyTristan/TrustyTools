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
    #-------------------------------------------------------------------------
    $WarningPreference = "SilentlyContinue"
    #-------------------------------------------------------------------------
Describe 'Get-FullName Public Function Tests' -Tag Unit {
    # Define test cases
    Context "When the input object has both GivenName and Surname" {
        It "Returns the concatenated GivenName and Surname" {
            $TestInput = [PSCustomObject]@{
                GivenName = "John"
                Surname = "Doe"
            }
            $ExpectedOutput = "John Doe"
            $ActualOutput = Get-FullName -Identity $TestInput

            $ActualOutput | Should -BeExactly $expectedOutput
        }
    }
    Context "When the input object has just the GivenName" {
        It "Returns the GivenName" {
            $TestInput = [PSCustomObject]@{
                GivenName = "John"
            }
            $ExpectedOutput = "John"
            $ActualOutput = Get-FullName -Identity $TestInput

            $ActualOutput | Should -BeExactly $expectedOutput
        }
    }
    Context "When the input object has just the Surname" {
        It "Returns the Surname" {
            $TestInput = [PSCustomObject]@{
                Surname = "Doe"
            }
            $ExpectedOutput = "Doe"
            $ActualOutput = Get-FullName -Identity $TestInput

            $ActualOutput | Should -BeExactly $expectedOutput
        }
    }
    Context "Invalid input" {
        It "Throws an error for empty input" {
            $TestInput = ''
            { Get-FullName -Identity $TestInput } | Should -Throw
        }

        It "Throws an error for null input" {
            { Get-FullName -Identity $null } | Should -Throw
        }
    }
}
}