import-module au
. $([System.IO.Path]::Combine((Split-Path -Parent $PSScriptRoot), '.scripts', 'Get-GithubLatestReleaseLinks.ps1'))


function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(^[$]version\s*=\s*)('.*')"  = "`$1'$($Latest.Version)'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
        ".\reeeplayer.install.nuspec"   = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $rel = (Get-GitHubLatestReleaseLinks -user 'FilippVolodin' -repository 'ReeePlayer').Links | % href
    $relative_url  = $rel | Where-Object { $_ -match '/FilippVolodin/ReeePlayer/releases/download/v\d+\.\d+(\.\d+)*/ReeePlayer-\d+\.\d+(\.\d+)*-win-x64-installer\.exe' } | Select-Object -First 1
    $version = ([regex]::Match($relative_url, 'ReeePlayer-(\d+\.\d+(\.\d+)*)-win-x64-installer\.exe')).Groups[1].Value
    @{
        Version      = $version
        ReleaseNotes = "https://github.com/FilippVolodin/ReeePlayer/releases/tag/v$version"
    }
}

Update-Package -ChecksumFor 64
