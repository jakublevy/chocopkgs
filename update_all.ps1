# AU Packages Template: https://github.com/majkinetor/au-packages-template

param([string[]] $Name, [string] $ForcedPackages, [string] $Root = $PSScriptRoot)

$dead = @(
    'grap',
    'flip',
    'xxd',
    'dualiza',
    'quiet',
    'getuserinfo',
    'w2klockdesktop',
    'mairix',
    'amp-winoff',
    'amp-winoff.install',
    'amp-winoff.portable',
    'kindle-comic-converter',
    'glucose',
    'winflashtool',
    'winflashtool.portable',
    'scantailor-advanced',
    'mp3infpu',
    'pdfcrack',
    'tclocklight-kt',
    'painttoolsai',
    'vlna',
    'zkanji',
    'zkanji.install',
    'zkanji.portable',
    'undark',
    'revosleep',
    'showdate',
    'reeeplayer',
    'reeeplayer.portable'
)

$allPkgs = Get-ChildItem | ? { Test-Path "$_\update.ps1" } | Select-Object -exp Name
$notDeadNames = $allPkgs | ? { !$dead.Contains($_) }

$Options = [ordered]@{
    WhatIf        = $au_WhatIf                              #Whatif all packages
    Force         = $false                                  #Force all packages
    Timeout       = 200                                     #Connection timeout in seconds
    UpdateTimeout = 1200                                    #Update timeout in seconds
    Threads       = 1                                       #Number of background jobs to use
    Push          = $Env:au_Push -eq 'true'                 #Push to chocolatey
    PushAll       = $true                                   #Allow to push multiple packages at once
    PluginPath    = ''                                      #Path to user plugins
    IgnoreOn      = @(                                      #Error message parts to set the package ignore status
      'Could not create SSL/TLS secure channel'
      'Could not establish trust relationship'
      'The operation has timed out'
      'Internal Server Error'
      'Service Temporarily Unavailable'
    )
    RepeatOn      = @(                                      #Error message parts on which to repeat package updater
      'Could not create SSL/TLS secure channel'             # https://github.com/chocolatey/chocolatey-coreteampackages/issues/718
      'Could not establish trust relationship'              # -||-
      'Unable to connect'
      'The remote name could not be resolved'
      'Choco pack failed with exit code 1'                  # https://github.com/chocolatey/chocolatey-coreteampackages/issues/721
      'The operation has timed out'
      'Internal Server Error'
      'An exception occurred during a WebClient request'
      'remote session failed with an unexpected state'
    )
    RepeatSleep   = 250                                    #How much to sleep between repeats in seconds, by default 0
    RepeatCount   = 2                                      #How many times to repeat on errors, by default 1
    
    #NoCheckChocoVersion = $true                            #Turn on this switch for all packages

    Report = @{
        Type = 'markdown'                                   #Report type: markdown or text
        Path = "$PSScriptRoot\Update-AUPackages.md"         #Path where to save the report
        Params= @{                                          #Report parameters:
       #     Github_UserRepo = $Env:github_user_repo         #  Markdown: shows user info in upper right corner
            NoAppVeyor  = $false                            #  Markdown: do not show AppVeyor build shield
       #     UserMessage = "[Ignored](#ignored) | [History](#update-history) | [Force Test](https://gist.github.com/$Env:gist_id_test) | [Releases](https://github.com/$Env:github_user_repo/tags)"       #  Markdown, Text: Custom user message to show
            NoIcons     = $false                            #  Markdown: don't show icon
            IconSize    = 32                                #  Markdown: icon size
            Title       = ''                                #  Markdown, Text: TItle of the report, by default 'Update-AUPackages'
        }
    }

    History = @{
        Lines = 120                                         #Number of lines to show
        Github_UserRepo = $Env:github_user_repo             #User repo to be link to commits
        Path = "$PSScriptRoot\Update-History.md"            #Path where to save history
    }

    # Gist = @{
    #     Id     = $Env:gist_id                               #Your gist id; leave empty for new private or anonymous gist
    #     ApiKey = $Env:github_api_key                        #Your github api key - if empty anoymous gist is created
    #     Path   = "$PSScriptRoot\Update-AUPackages.md", "$PSScriptRoot\Update-History.md"       #List of files to add to the gist
    # }

    Git = @{
        User     = ''                                       #Git username, leave empty if github api key is used
        Password = $Env:github_api_key                      #Password if username is not empty, otherwise api key
    }

    # GitReleases  = @{
    #     ApiToken    = $Env:github_api_key                   #Your github api key
    #     ReleaseType = 'package'                             #Either 1 release per date, or 1 release per package
    # }

    # RunInfo = @{
    #     Exclude = 'password', 'apikey', 'apitoken'          #Option keys which contain those words will be removed
    #     Path    = "$PSScriptRoot\update_info.xml"           #Path where to save the run info
    # }

    Mail = if ($Env:mail_user) {
            @{
                To         = $Env:mail_to
                From       = $Env:mail_user
                Server     = $Env:mail_server
                UserName   = $Env:mail_user
                Password   = $Env:mail_pass
                Port       = $Env:mail_port
                EnableSsl  = $Env:mail_enablessl -eq 'true'
                Attachment = "$PSScriptRoot\Update-History.md"
                UserMessage = 'chocopkgs'
                SendAlways  = $false                      #Send notifications every time
             }
           } else {}

    ForcedPackages = $ForcedPackages -split ' '
    BeforeEach = {
        param($PackageName, $Options )

        $pattern = "^${PackageName}(?:\\(?<stream>[^:]+))?(?:\:(?<version>.+))?$"
        $p = $Options.ForcedPackages | ? { $_ -match $pattern }
        if (!$p) { return }

        $global:au_Force         = $true
        $global:au_IncludeStream = $Matches['stream']
        $global:au_Version       = $Matches['version']
    }
}

if ($ForcedPackages) { Write-Host "FORCED PACKAGES: $ForcedPackages" }
$global:au_Root         = $Root          #Path to the AU packages
$global:au_GalleryUrl   = ''             #URL to package gallery, leave empty for Chocolatey Gallery
if($null -eq $Name) {
  $global:info = updateall -Name $notDeadNames -Options $Options
}
else {
  $global:info = updateall -Name $Name -Options $Options
}

#Uncomment to fail the build on AppVeyor on any package error
#if ($global:info.error_count.total) { throw 'Errors during update' }
