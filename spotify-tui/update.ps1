import-module au
. $([System.IO.Path]::Combine((Split-Path -Parent $PSScriptRoot), '.scripts', 'Get-GithubLatestReleaseLinks.ps1'))


function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(?i)(^\s*fileFullPath64\s*=\s*)(.*)"  = "`${1}Join-Path `$toolsDir '$($Latest.FileName64)'"
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+Go to).*"          = "`${1} $($Latest.Url64)"
            "(?i)(\s+checksum64:).*"    = "`${1} $($Latest.Checksum64)"
        }
        ".\spotify-tui.nuspec" = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $rel = (Get-GitHubLatestReleaseLinks -user 'Rigellute' -repository 'spotify-tui').Links | % href
    $relative_url  = $rel | Where-Object { $_ -match '/Rigellute/spotify-tui/releases/download/v\d+\.\d+(\.\d+)*/spotify-tui-windows\.tar\.gz' } | Select-Object -First 1
    $version = ([regex]::Match($relative_url, 'v(\d+\.\d+(\.\d+)*)')).Groups[1].Value
    @{
        Version      = $version
        Url64        = "https://github.com/Rigellute/spotify-tui/releases/download/v$version/spotify-tui-windows.tar.gz"
        ReleaseNotes = "https://github.com/Rigellute/spotify-tui/releases/tag/v$version"
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -NoSuffix -Purge
}

Update-Package -ChecksumFor None
