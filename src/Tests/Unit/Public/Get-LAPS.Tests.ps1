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
    Describe 'Get-LAPS Public Function Tests' -Tag Unit {
        BeforeAll {
            $WarningPreference = 'SilentlyContinue'
            $ErrorActionPreference = 'SilentlyContinue'
            function Get-ADComputer {
                return "ADComputer"
            }
        } #beforeAll
        Context "When valid computer and server parameters are provided" {
            BeforeEach {
                Mock Get-ADComputer {
                    param($Identity)
                    if ($Identity -eq 'Computer1') {
                        return [PSCustomObject]@{
                            Name = 'Computer1';
                            'ms-Mcs-AdmPwd' = 'superpassword1';
                        }
                    }
                }
            }
            It "Should return an array of passwords" {
                $result = Get-LAPS -Computer 'Computer1'
                $result.Name | Should -Be 'Computer1'
                $result.Password | Should -Be 'superpassword1'
            }

            Context "When multiple computers are provided" {
                BeforeEach {
                    Mock Get-ADComputer {
                        param($Identity)
                        if ($Identity -eq 'Computer1') {
                            return [PSCustomObject]@{
                                Name = 'Computer1';
                                'ms-Mcs-AdmPwd' = 'superpassword1';
                            }
                        } elseif ($Identity -eq 'Computer2') {
                            return [PSCustomObject]@{
                                Name = 'Computer2';
                                'ms-Mcs-AdmPwd' = 'superpassword2';
                            }
                        }
                    }
                }

                It "Should return an array of computers and passwords sorted by name" {
                    $result = Get-LAPS -Computer 'Computer2', 'Computer1'
                    $result.Count | Should -Be 2
                    $result[0].Name | Should -Be 'Computer1'
                    $result[0].Password | Should -Be 'superpassword1'
                    $result[1].Name | Should -Be 'Computer2'
                    $result[1].Password | Should -Be 'superpassword2'
                }
            }

            Context "Invalid input" {
                It "Throws an error for empty input" {
                    { Get-LAPS @() } | Should -Throw
                }

                It "Throws an error for null input" {
                    { Get-LAPS $null } | Should -Throw
                }
            }
        }

    }
}