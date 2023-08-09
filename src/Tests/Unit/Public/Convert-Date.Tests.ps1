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
    Describe 'Convert-Date Public Function Tests' -Tag Unit {
        BeforeAll {
            $WarningPreference = 'SilentlyContinue'
            $ErrorActionPreference = 'SilentlyContinue'
        } #beforeAll
        Context 'Converts Unix time' {
            It 'should return the expected results' {
                $ExpectedOutput = '2023/08/08'
                $ActualOutput = Convert-Date -InputDate 1691469420420
                $ActualOutput | Should -BeExactly $ExpectedOutput
            }
        }
        Context 'Converts Written time' {
            It 'should return the expected results' {
                $ExpectedOutput = '2023/08/09'
                $ActualOutput = Convert-Date -InputDate 'Wednesday, August 9, 2023 10:20:28 AM'
                $ActualOutput | Should -BeExactly $ExpectedOutput
            }
        }
        Context 'Converts Written time to format' {
            It 'should return the expected results' {
                $ExpectedOutput = '20230809102028'
                $ActualOutput = Convert-Date -InputDate 'Wednesday, August 9, 2023 10:20:28 AM' -Format 'yyyyMMddhhmmss'
                $ActualOutput | Should -BeExactly $ExpectedOutput
            }
        }

        Context "Invalid input" {
            It "Throws an error for empty input" {
                { Convert-Date @() } | Should -Throw
            }

            It "Throws an error for null input" {
                { Convert-Date $null } | Should -Throw
            }
        }
    }
}