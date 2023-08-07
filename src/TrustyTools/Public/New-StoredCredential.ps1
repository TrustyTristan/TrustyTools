<#
.SYNOPSIS
    Saves credential as .cred
.DESCRIPTION
    Use to save PowerShell credentials to file.
    By default it will use the current user and the current users PowerShell config path.
.EXAMPLE
    PS> New-StoredCredential -UserName "trusty"

    PowerShell credential request
    Please enter password
    Password for user trusty: ********

    Credentials saved to '/user/.config/powershell/credentials/trusty.cred'
.PARAMETER UserName
    Specifies the UserName
.PARAMETER Path
    Specifies the file path
    Default is: ~\User\.config\powershell\credentials
.PARAMETER Force
    Overwrites the existing file
.OUTPUTS
    System.String
.COMPONENT
    TrustyTools
#>
function New-StoredCredential {

    [CmdletBinding(SupportsShouldProcess)]
    param (
        [Parameter(Mandatory = $false,
            HelpMessage = 'Please incldude the domain if required')]
        [ValidateNotNullOrEmpty()]
        [string]$UserName = (whoami),

        [Parameter(Mandatory = $false,
            HelpMessage = 'Please a system file path')]
        [ValidateNotNullOrEmpty()]
        [System.IO.FileInfo]$Path = (Join-Path -Path (Split-Path $Profile) -ChildPath "credentials"),

        [Parameter()]
        [switch]$Force
    )

    BEGIN {
        New-Item -Path $Path -ItemType Directory -ErrorAction SilentlyContinue | Out-Null
    }

    PROCESS {
        $FileName = $UserName -split '\\'
        if ( $FileName.Count -eq 2 ) {
            $Domain   = $FileName[0]
            $UserName = $FileName[1]
            $FileName = "($Domain)$UserName"
        }
        $FilePath = Join-Path -Path $Path -ChildPath "$FileName.cred"
        if ( $Force -or -not (Test-Path -Path $FilePath )) {
            $Credential = Get-Credential -UserName $Username -Message "Please enter password"
            $Credential.UserName | Out-File -FilePath $FilePath -Force
            if ( $FilePath ) {
                $Credential.Password | ConvertFrom-SecureString | Out-File -FilePath $FilePath -Append
                Write-Output "Credentials saved to `'$($FilePath)`'"
            }
        } else {
            $FileDetails = Get-ItemProperty -Path $FilePath
            Write-Error "The file `'$($FileDetails.FullName)`' already exists.`nLast Write: $($FileDetails.LastWriteTime)"
            Write-Error "Use -Force to overwrite."
        }
    }
}