import-module chocolatey-au
. $([System.IO.Path]::Combine((Split-Path -Parent $PSScriptRoot), '.scripts', 'Get-GithubLatestReleaseLinks.ps1'))


function global:au_SearchReplace {
    @{
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+Go to).*"         = "`${1} $($Latest.Url64)"
            "(?i)(\s+checksum64:).*"   = "`${1} $($Latest.Checksum64)"
        }
        ".\ugrep.nuspec" = @{
            "(?i)(<releaseNotes>).*(</releaseNotes>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $rel = (Get-GitHubLatestReleaseLinks -user 'Genivia' -repository 'ugrep').Links | % href
    $relative_url  = $rel | Where-Object { $_ -match '/Genivia/ugrep/releases/download/v\d+\.\d+(\.\d+)*/ugrep-windows-x64\.zip' } | Select-Object -First 1
    $version = ([regex]::Match($relative_url, '/v(\d+\.\d+(\.\d+)*)/')).Groups[1].Value
    @{
        Url64        = "https://github.com/Genivia/ugrep/releases/download/v$version/ugrep-windows-x64.zip"
        Version      = $version
        ReleaseNotes = "https://github.com/Genivia/ugrep/releases/tag/v$version"
    }
}
function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix
}

Update-Package -ChecksumFor None