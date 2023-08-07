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
    Describe 'Get-Day Public Function Tests' -Tag Unit {
        BeforeAll {
            $WarningPreference = 'SilentlyContinue'
            $ErrorActionPreference = 'SilentlyContinue'
        } #beforeAll

        It "Returns an ordered dictionary with the name and CN" {
            # Sample input data
            $inputCN = @(
                'CN=GroupName1,OU=Groups,DC=some,DC=domain,DC=name',
                'CN=GroupName2,OU=Groups,DC=some,DC=domain,DC=name',
                'CN=GroupName3,OU=Groups,DC=some,DC=domain,DC=name'
            )

            # Expected output
            $expectedOutput = [ordered]@{
                'GroupName1' = 'CN=GroupName1,OU=Groups,DC=some,DC=domain,DC=name'
                'GroupName2' = 'CN=GroupName2,OU=Groups,DC=some,DC=domain,DC=name'
                'GroupName3' = 'CN=GroupName3,OU=Groups,DC=some,DC=domain,DC=name'
            }

            # Invoke the function with the input data
            $actualOutput = Get-NameFromCN -CN $inputCN

            # Perform the test assertion
            $actualOutput | Should -BeLikeExactly $expectedOutput
        }
    }

    Context "Invalid input" {
        It "Throws an error for empty input" {
            { Get-NameFromCN -CN @() } | Should -Throw
        }

        It "Throws an error for null input" {
            { Get-NameFromCN -CN $null } | Should -Throw
        }
    }

} #inModule
