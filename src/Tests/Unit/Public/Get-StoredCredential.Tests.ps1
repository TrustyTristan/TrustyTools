# PSScriptAnalyzer - ignore creation of a SecureString using plain text for the contents of this script file
[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingConvertToSecureStringWithPlainText", "")]
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
    Describe 'Get-StoredCredential Public Function Tests' -Tag Unit {
        BeforeAll {
            $WarningPreference = 'SilentlyContinue'
            $ErrorActionPreference = 'SilentlyContinue'
            Mock Get-ChildItem {
                return [PSCustomObject]@{
                    FullName = "C:\Path\To\Credentials\user.cred"
                    BaseName = "user"
                }
            }

            # Mock Get-Content to return a sample credential content
            Mock Get-Content {
                return @("user", "$(ConvertTo-SecureString -String "password" -AsPlainText -Force | ConvertFrom-SecureString)")
            }
        } #beforeAll

        Context "When a valid username is provided" {
            It "Should return a PSCredential object" {
                $ActualOutput = Get-StoredCredential -UserName "user"
                $ActualOutput.Password.GetType().Name | Should -Be "SecureString"
                $ActualOutput.UserName | Should -Be "user"
            }
        }

        Context "When the credential file does not exist" {
            It "Should write an error message" {
                { Get-StoredCredential -UserName "nonexistent@trusty.domain" -ErrorAction Stop } | Should -Throw
            }
        }

        Context "Invalid input" {
            It "Throws an error for empty input" {
                { Get-StoredCredential @() } | Should -Throw
            }

            It "Throws an error for null input" {
                { Get-StoredCredential $null } | Should -Throw
            }
        }
    }
}