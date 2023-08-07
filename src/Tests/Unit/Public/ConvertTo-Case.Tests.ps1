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
    Describe 'ConvertTo-Case Public Function Tests' -Tag Unit {
        BeforeAll {
            $WarningPreference = 'SilentlyContinue'
            $ErrorActionPreference = 'SilentlyContinue'
            $script:TestInput = @(
                    "She looked at me with big, round eyes (<perfect>).",
                    "What?! I can't believe it!",
                    'The crowd cheered, "Hooray!"',
                    '{Open the door!}',
                    '[The key is Missing.]',
                    '(run for cover!)',
                    "It's all gone wrong ''again''!",
                    '"Help! I need somebody!"'
                )
        } #beforeAll
        Context 'Converts strings case to UPPERCASE' {
            It 'should return the expected results' {
                $ExpectedOutput = @(
                    "SHE LOOKED AT ME WITH BIG, ROUND EYES (<PERFECT>).",
                    "WHAT?! I CAN'T BELIEVE IT!",
                    'THE CROWD CHEERED, "HOORAY!"',
                    '{OPEN THE DOOR!}',
                    '[THE KEY IS MISSING.]',
                    '(RUN FOR COVER!)',
                    "IT'S ALL GONE WRONG ''AGAIN''!",
                    '"HELP! I NEED SOMEBODY!"'
                )
                $ActualOutput = ConvertTo-Case -String $TestInput -Type UpperCase
                $ActualOutput | Should -BeExactly $ExpectedOutput
            }
        }
        Context 'Converts strings case to lowercase' {
            It 'should return the expected results' {
                $ExpectedOutput = @(
                    "she looked at me with big, round eyes (<perfect>).",
                    "what?! i can't believe it!",
                    'the crowd cheered, "hooray!"',
                    '{open the door!}',
                    '[the key is missing.]',
                    '(run for cover!)',
                    "it's all gone wrong ''again''!",
                    '"help! i need somebody!"'
                )
                $ActualOutput = ConvertTo-Case -String $TestInput -Type LowerCase
                $ActualOutput | Should -BeExactly $ExpectedOutput
            }
        }
        Context 'Converts strings case to StartCase' {
            It 'should return the expected results' {
                $ExpectedOutput = @(
                    "She Looked At Me With Big, Round Eyes (<Perfect>).",
                    "What?! I Can't Believe It!",
                    'The Crowd Cheered, "Hooray!"',
                    '{Open The Door!}',
                    '[The Key Is Missing.]',
                    '(Run For Cover!)',
                    "It's All Gone Wrong ''Again''!",
                    '"Help! I Need Somebody!"'
                )
                $ActualOutput = ConvertTo-Case -String $TestInput -Type StartCase
                $ActualOutput | Should -BeExactly $ExpectedOutput
            }
        }
        Context 'Converts strings case to camelCase' {
            It 'should return the expected results' {
                $ExpectedOutput = @(
                    "she Looked At Me With Big, Round Eyes (<perfect>).",
                    "what?! i Can't Believe It!",
                    'the Crowd Cheered, "hooray!"',
                    '{open The Door!}',
                    '[the Key Is Missing.]',
                    '(run For Cover!)',
                    "it's All Gone Wrong ''again''!",
                    '"help! i Need Somebody!"'
                )
                $ActualOutput = ConvertTo-Case -String $TestInput -Type CamelCase
                $ActualOutput | Should -BeExactly $ExpectedOutput
            }
        }
        Context 'Converts strings case to SentenceCase' {
            It 'should return the expected results' {
                $ExpectedOutput = @(
                    "She looked at me with big, round eyes (<Perfect>).",
                    "What?! I can't believe it!",
                    'The crowd cheered, "Hooray!"',
                    '{Open the door!}',
                    '[The key is missing.]',
                    '(Run for cover!)',
                    "It's all gone wrong ''Again''!",
                    '"Help! I need somebody!"'
                )
                $ActualOutput = ConvertTo-Case -String $TestInput -Type SentenceCase
                $ActualOutput | Should -BeExactly $ExpectedOutput
            }
        }
        Context 'Converts strings case to iNsAnEcAsE' {
            It 'should return the expected results' {
                $ExpectedOutput = @(
                        "sHe LoOKeD aT ME WitH BIg, rOuND EyeS (<pErfEcT>).",
                        "wHat?! I Can't BeLieVe It!",
                        'tHe CrOWd chEeREd, "HoORaY!"',
                        '{OpeN THe doOr!}',
                        '[The kEY Is MiSSiNg.]',
                        '(Run fOR CovEr!)',
                        "iT's aLL GonE WRoNg ''AGaIn''!",
                        '"HelP! I NeeD SOmEboDy!"',

                        "She lOOkEd At Me wiTh BiG, RoUNd eyEs (<PerFeCT>).",
                        "WhaT?! i caN'T bEliEvE iT!",
                        'The cROwD cHeEReD, "hOOrAy!"',
                        '{opEn ThE dOoR!}',
                        '[thE KEy is mISsIng.]',
                        '(ruN FOr coVeR!)',
                        "It'S ALl goNe WrOng ''AgAin''!",
                        '"heLp! i neEd SoMebOdY!"',

                        "ShE LoOkEd aT Me wItH BiG, rOuNd eYeS (<PeRfEcT>).",
                        "WhAt?! i cAn't bElIeVe iT!",
                        'ThE CrOwD ChEeReD, "HoOrAy!"',
                        '{oPeN ThE DoOr!}',
                        '[tHe kEy iS MiSsInG.]',
                        '(rUn fOr cOvEr!)',
                        "It's aLl gOnE WrOnG ''AgAiN''!",
                        '"hElP! i nEeD SoMeBoDy!"',

                        "sHe lOoKeD At mE WiTh bIg, RoUnD EyEs (<pErFeCt>).",
                        "wHaT?! I CaN'T BeLiEvE It!",
                        'tHe cRoWd cHeErEd, "hOoRaY!"',
                        '{OpEn tHe dOoR!}',
                        '[ThE KeY Is mIsSiNg.]',
                        '(RuN FoR CoVeR!)',
                        "iT'S AlL GoNe wRoNg ''aGaIn''!",
                        '"HeLp! I NeEd sOmEbOdY!"'
                )
                $ActualOutput = ConvertTo-Case -String $TestInput -Type InsaneCase
                $ActualOutput | Should -BeIn $ExpectedOutput
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