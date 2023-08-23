param()
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
    Describe 'Get-BitLockerKey Public Function Tests' -Tag Unit {
        BeforeAll {
            $WarningPreference = 'SilentlyContinue'
            $ErrorActionPreference = 'SilentlyContinue'
            function Get-ADComputer {
                "ADComputer"
            }
            function Get-ADObject {
                "ADObject"
            }
        } #beforeAll
        Context "When valid computer and server parameters are provided" {
            BeforeEach {
                Mock Get-ADComputer {
                    [PSCustomObject]@{
                        Name = 'Computer1';
                        DistinguishedName = 'CN=Computer1,OU=Computers,DC=example,DC=com'
                    }
                }
                Mock Get-ADObject {
                    $adobject = [System.Collections.Generic.List[System.Object]]@()
                    $adobject.Add([PSCustomObject]@{
                        'msFVE-RecoveryPassword' = '1234567890';
                        'Created' = '2023-08-14T12:34:56'
                    })
                    return $adobject
                }
            }
            It "Should return an array of BitLocker keys" {
                $result = Get-BitLockerKey -Computer 'Computer1'
                $result.Count | Should -Be 1
                $result.Name | Should -Be 'Computer1'
                $result.Date | Should -Be '2023/08/14 12:34:56 PM'
                $result.Key | Should -Be '1234567890'
            }

            Context "When multiple keys are provided" {
                BeforeEach {
                    Mock Get-ADComputer { [PSCustomObject]@{ Name = 'Computer1'; DistinguishedName = 'CN=Computer1,OU=Computers,DC=example,DC=com' } }
                    Mock Get-ADObject {
                        $adobject = [System.Collections.Generic.List[System.Object]]@()
                        $adobject.Add([PSCustomObject]@{ 'msFVE-RecoveryPassword' = '0987654321'; 'Created' = '2023-08-13T10:20:30' })
                        $adobject.Add([PSCustomObject]@{ 'msFVE-RecoveryPassword' = '1234567890'; 'Created' = '2023-08-14T12:34:56' })
                        return $adobject
                    }
                }

                It "Should return an array of BitLocker keys sorted by date" {
                    $result = Get-BitLockerKey -Computer 'Computer1'
                    $result.Count | Should -Be 2
                    $result[0].Date | Should -Be '2023/08/14 12:34:56 PM'
                    $result[1].Date | Should -Be '2023/08/13 10:20:30 AM'
                }
            }

            Context "When multiple computers are provided" {
                BeforeEach {
                    Mock Get-ADComputer { [PSCustomObject]@{ Name = 'Computer1'; DistinguishedName = 'CN=Computer1,OU=Computers,DC=example,DC=com' } }
                    Mock Get-ADObject {
                        $adobject = [System.Collections.Generic.List[System.Object]]@()
                        $adobject.Add([PSCustomObject]@{ 'msFVE-RecoveryPassword' = '0987654321'; 'Created' = '2023-08-13T10:20:30' })
                        return $adobject
                    }
                }

                It "Should return an array of BitLocker keys for each computer" {
                    $result = Get-BitLockerKey -Computer 'Computer1', 'Computer2'
                    $result.Count | Should -Be 2
                }
            }

            Context "Invalid input" {
                It "Throws an error for empty input" {
                    { Get-BitLockerKey @() } | Should -Throw
                }

                It "Throws an error for null input" {
                    { Get-BitLockerKey $null } | Should -Throw
                }
            }
        }

    }
}