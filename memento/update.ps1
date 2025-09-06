import-module chocolatey-au
. $([System.IO.Path]::Combine((Split-Path -Parent $PSScriptRoot), '.scripts', 'Get-GithubLatestReleaseLinks.ps1'))


function global:au_SearchReplace {
    @{
        ".\memento.nuspec" = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
            "(\<dependency .+?`"memento.install`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
        }
    }
}

function global:au_GetLatest {
    $rel = (Get-GitHubLatestReleaseLinks -user 'ripose-jp' -repository 'Memento').Links | % href
    $relative_url  = $rel | Where-Object { $_ -match '/ripose-jp/Memento/releases/download/v\d+\.\d+(\.\d+)*(-\d+)?(-beta)?/Memento_Windows_x86_64\.zip' } | Select-Object -First 1
    $versionFull = ([regex]::Match($relative_url, '/download/v(\d+\.\d+(\.\d+)*(-\d+)?(-beta)?)/Memento_Windows_x86_64.zip')).Groups[1].Value
    $version = ([regex]::Match($relative_url, '(\d+\.\d+(\.\d+)*(-\d+)?)(-beta)?')).Groups[1].Value
    $version = $version.Replace('-', '.')
    @{
        Version      = $version
        ReleaseNotes = "https://github.com/ripose-jp/Memento/releases/tag/v$versionFull"
    }
}

Update-Package -ChecksumFor None 
