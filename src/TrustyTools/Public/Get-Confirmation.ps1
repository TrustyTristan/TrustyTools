<#
.SYNOPSIS
    Prompt for confirmation
.DESCRIPTION
    Function to prompt for user confirmation before proceding.
.EXAMPLE
    PS> Get-Confirmation -Title "Create Mailbox" -Message "Are you sure you want to create with these details"

    Create Mailbox
    Are you sure you want to create with these details
    [Y] Yes  [N] No  [?] Help (default is "Y"):
.EXAMPLE
    PS> Get-Confirmation -Title "Delete Mailbox" -Message "Are you sure you want to delete `'$MailboxVar`'?" -Default No

    Delete Mailbox
    Are you sure you want to delete 'my@mailbox.var'?
    [Y] Yes  [N] No  [?] Help (default is "N"):
.PARAMETER Title
    Specifies the action that will be performed
.PARAMETER Message
    Specifies the question about what will be performed'
.PARAMETER YesHelp
    Specifies the Help message for Yes action
.PARAMETER NoHelp
    Specifies the Help message for No action
.PARAMETER Default
    Specifies the default action. (Default is yes)
.OUTPUTS
    System.Boolean
.COMPONENT
    TrustyTools
#>
function Get-Confirmation {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false,
            HelpMessage = 'The action that will be performed')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$Title,

        [Parameter(Mandatory = $false,
            HelpMessage = 'Question about what will be performed')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$Message = 'Do you want to continue?',

        [Parameter(Mandatory = $false,
            HelpMessage = 'Help message for Yes action')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$YesHelp = 'Proceeds with action',

        [Parameter(Mandatory = $false,
            HelpMessage = 'Help message for No action')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [string]$NoHelp  = 'Skips the action',

        [Parameter(Mandatory = $false,
            HelpMessage = 'Help message for No action')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('Yes', 'No')]
        [string]$Default = 'Yes'
    )

    BEGIN {
        switch ($Default) {
            Yes {[int]$Default = 0}
            No  {[int]$Default = 1}
        }
        $Yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", $YesHelp
        $No = New-Object System.Management.Automation.Host.ChoiceDescription "&No", $NoHelp
        $Options = [System.Management.Automation.Host.ChoiceDescription[]]($Yes, $No)
    }

    PROCESS {
        do {
            $Response = $Host.UI.PromptForChoice($Title, $Message, $Options, $Default)
            if ($Response -eq 0) {
                return $true
            }
        } until ($Response -eq 1)
    }

}