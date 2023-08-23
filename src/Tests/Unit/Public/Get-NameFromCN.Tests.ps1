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
    Describe 'Get-NameFromCN Public Function Tests' -Tag Unit {
        BeforeAll {
            $WarningPreference = 'SilentlyContinue'
            $ErrorActionPreference = 'SilentlyContinue'
        } #beforeAll

        It "Returns an ordered dictionary the name and CN" {
            # Sample input data
            $inputCN = @(
                'CN=GroupName1,OU=Groups,DC=some,DC=domain,DC=name',
                'CN=GroupName2,OU=Groups,DC=some,DC=domain,DC=name',
                'CN=GroupName3,OU=Groups,DC=some,DC=domain,DC=name'
            )

            # Expected output
            $expectedOutput = New-Object System.Collections.Generic.List[System.Object]
            $expectedOutput.Add([PSCustomObject]@{Name = 'GroupName1';CN = 'CN=GroupName1,OU=Groups,DC=some,DC=domain,DC=name';})
            $expectedOutput.Add([PSCustomObject]@{Name = 'GroupName2';CN = 'CN=GroupName2,OU=Groups,DC=some,DC=domain,DC=name';})
            $expectedOutput.Add([PSCustomObject]@{Name = 'GroupName3';CN = 'CN=GroupName3,OU=Groups,DC=some,DC=domain,DC=name';})

            # Invoke the function with the input data
            $actualOutput = Get-NameFromCN -CN $inputCN
            $actualOutput.Count | Should -BeExactly 3
            $actualOutput.GetType().FullName | Should -BeExactly 'System.Object[]'

            # Perform the test assertion
            $actualOutput[0].CN | Should -Be $expectedOutput[0].CN
            $actualOutput[1].Name | Should -Be $expectedOutput[1].Name
            #$actualOutput[2] | Should -Be $expectedOutput[2]
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
