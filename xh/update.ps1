import-module au
. $([System.IO.Path]::Combine((Split-Path -Parent $PSScriptRoot), '.scripts', 'Get-GithubLatestReleaseLinks.ps1'))


function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(?i)(^\s*fileFullPath64\s*=\s*)(.*)" = "`${1}Join-Path `$toolsDir '$($Latest.FileName64)'"
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+Go to).*"         = "`${1} $($Latest.Url64)"
            "(?i)(\s+checksum64:).*"   = "`${1} $($Latest.Checksum64)"
        }
        ".\xh.nuspec" = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $rel = (Get-GitHubLatestReleaseLinks -user 'ducaale' -repository 'xh').Links | % href
    $relative_url  = $rel | Where-Object { $_ -match '/ducaale/xh/releases/download/v\d+\.\d+(\.\d+)*/xh-v\d+\.\d+(\.\d+)*-x86_64-pc-windows-msvc\.zip' } | Select-Object -First 1
    $version = ([regex]::Match($relative_url, '/v(\d+\.\d+(\.\d+)*)/')).Groups[1].Value
    @{
        Url64        = "https://github.com/ducaale/xh/releases/download/v$version/xh-v$version-x86_64-pc-windows-msvc.zip"
        Version      = $version
        ReleaseNotes = "https://github.com/ducaale/xh/releases/tag/v$version"
    }
}
function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix
}

Update-Package -ChecksumFor None