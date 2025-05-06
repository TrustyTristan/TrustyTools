<#
.SYNOPSIS
    Get both the calendar folder permissions and if the user is in the book in policy
.DESCRIPTION
    Get both the calendar folder permissions and if the user is in the book in policy
.EXAMPLE
    PS> Get-CalendarPermissions -Identity Trusty@trusty.co

    DisplayName      Alias     Permission     Bookin
    -----------      -----     ----------     ------
    Trusty Tristan   trusty    LimitedDetails True

.PARAMETER Identity
    Specifies a mailbox identity
#>
function Get-CalendarPermission {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
            HelpMessage = 'Please specify the UserPrincipalName or Alias of the mailbox')]
        [ValidateNotNullOrEmpty()]
        [string]$Identity
    )

    # Get Book In Policy
    $CalendarProcessing = Get-CalendarProcessing -Identity $Identity

    # Create Calendar Folder
    $CalendarFolder = -join ($Identity, ':\Calendar')

    # Get Calendar Folder Permissionsw
    $FolderPermissions = Get-MailboxFolderPermission -Identity $CalendarFolder

    $FolderPermissionsList = @()
    foreach ($Member in $FolderPermissions) {
        $FolderPermissionsList += New-Object -TypeName psobject -Property @{
            DisplayName = $Member.User.RecipientPrincipal.DisplayName
            Alias       = $Member.User.RecipientPrincipal.Alias
            Permission  = $Member.AccessRights
            Bookin      = ''
        }
    }

    $DeletedList = @()
    $BookInList = @()
    foreach ( $Member in $CalendarProcessing.BookInPolicy ) {
        try {
            $MemberProcessing = Get-Recipient $Member -ErrorAction Stop
        } catch {
            $DeletedList += $Member
        }
        $BookInList += New-Object -TypeName psobject -Property @{
            DisplayName = $MemberProcessing.DisplayName
            Alias       = $MemberProcessing.Alias
            Permission  = ''
            Bookin      = $true
        }
    }

    # Combine both lists because users could be in either
    $CombinedList = $FolderPermissionsList + $BookInList
    # Filter to unique values
    $Members = $CombinedList.Alias | Select-Object -Unique

    $Result = New-Object System.Collections.Generic.List[System.Object]

    foreach ( $Member in $Members ) {
        $Rows = $CombinedList | Where-Object { $_.Alias -eq $Member }
        $Result.Add(
            [PSCustomObject]@{
                DisplayName = ($Rows | Group-Object -Property DisplayName).Name | Where-Object {![string]::IsNullOrEmpty($_)}
                Alias       = ($Rows | Group-Object -Property Alias).Name | Where-Object {![string]::IsNullOrEmpty($_)}
                Permission  = ($Rows | Group-Object -Property Permission).Name | Where-Object {![string]::IsNullOrEmpty($_)}
                Bookin      = ($Rows | Group-Object -Property Bookin).Name | Where-Object {![string]::IsNullOrEmpty($_)}
            }
        )
    }

    if ( $DeletedList ) {
        Write-Information -MessageData "`nDeleted:" -InformationAction Continue
        $DeletedList | ForEach-Object {
            $_ -replace '^/o=.*/ou=.*/cn=.*/'
        }
    }

    $Result | Sort-Object -Property DisplayName

}