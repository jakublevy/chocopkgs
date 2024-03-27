import-module au
. $([System.IO.Path]::Combine((Split-Path -Parent $PSScriptRoot), '.scripts', 'Get-GithubLatestReleaseLinks.ps1'))


function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(?i)(^\s*fileFullPath\s*=\s*)(.*)"    = "`${1}Join-Path `$toolsDir '$($Latest.FileName32)'"
            "(?i)(^\s*fileFullPath64\s*=\s*)(.*)"  = "`${1}Join-Path `$toolsDir '$($Latest.FileName64)'"
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+x86:).*"          = "`${1} $($Latest.Url32)"
            "(?i)(\s+x64:).*"          = "`${1} $($Latest.Url64)"
            "(?i)(\s+checksum32:).*"   = "`${1} $($Latest.Checksum32)"
            "(?i)(\s+checksum64:).*"   = "`${1} $($Latest.Checksum64)"
        }
        ".\ddh.nuspec" = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $rel = (Get-GitHubLatestReleaseLinks -user 'dd86k' -repository 'ddh').Links | % href
    $relative_url  = $rel | Where-Object { $_ -match '/dd86k/ddgst/releases/download/v\d+\.\d+(\.\d+)*/ddh-\d+\.\d+(\.\d+)*-windows-mscoff-x86_64\.zip' } | Select-Object -First 1
    $version = ([regex]::Match($relative_url, 'v(\d+\.\d+(\.\d+)*)')).Groups[1].Value
    @{
        Version      = $version
        Url32        = "https://github.com/dd86k/ddgst/releases/download/v$version/ddh-$version-windows-mscoff-x86.zip"
        Url64        = "https://github.com/dd86k/ddgst/releases/download/v$version/ddh-$version-windows-mscoff-x86_64.zip"
        ReleaseNotes = "https://github.com/dd86k/ddgst/releases/tag/v$version"
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -NoSuffix -Purge
}

Update-Package -ChecksumFor None
