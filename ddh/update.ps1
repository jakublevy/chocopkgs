import-module chocolatey-au
. $([System.IO.Path]::Combine((Split-Path -Parent $PSScriptRoot), '.scripts', 'Get-GithubLatestReleaseLinks.ps1'))


function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(?i)(^\s*fileFullPath64\s*=\s*)(.*)"  = "`${1}Join-Path `$toolsDir '$($Latest.FileName64)'"
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\sGo to).*"          = "`${1} $($Latest.Url64)"
            "(?i)(\s+checksum64:).*"   = "`${1} $($Latest.Checksum64)"
        }
        ".\ddh.nuspec" = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $rel = (Get-GitHubLatestReleaseLinks -user 'dd86k' -repository 'ddgst').Links | % href
    $relative_url  = $rel | Where-Object { $_ -match '/dd86k/ddgst/releases/download/v\d+\.\d+(\.\d+)*/ddgst-.*-x86_64-windows-msvc\.zip' } | Select-Object -First 1
    $version = ([regex]::Match($relative_url, 'v(\d+\.\d+(\.\d+)*)')).Groups[1].Value
    $name_ver = ([regex]::Match($relative_url, 'ddgst-(.*)-x86_64')).Groups[1].Value
    @{
        Version      = $version
        Url64        = "https://github.com/dd86k/ddgst/releases/download/v$version/ddgst-$name_ver-x86_64-windows-msvc.zip"
        ReleaseNotes = "https://github.com/dd86k/ddgst/releases/tag/v$version"
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -NoSuffix -Purge
}

Update-Package -ChecksumFor None
