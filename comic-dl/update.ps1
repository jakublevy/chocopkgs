import-module au
. $([System.IO.Path]::Combine((Split-Path -Parent $PSScriptRoot), '.scripts', 'Get-GithubLatestReleaseLinks.ps1'))


function global:au_SearchReplace {
    @{
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+Go to).*"         = "`${1} $($Latest.Url64)"
            "(?i)(\s+checksum64:).*"   = "`${1} $($Latest.Checksum64)"
        }
        ".\comic-dl.nuspec" = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $rel = (Get-GitHubLatestReleaseLinks -user 'Xonshiz' -repository 'comic-dl').Links | % href
    $relative_url  = $rel | Where-Object { $_ -match '/Xonshiz/comic-dl/releases/download/\d+\.\d+(\.\d+)/comic_dl\.exe' } | Select-Object -First 1
    $version = ([regex]::Match($relative_url, '/(\d+\.\d+(\.\d+)*)/')).Groups[1].Value
    @{
        Version      = $version
        Url64        = "https://github.com/Xonshiz/comic-dl/releases/download/$version/comic_dl.exe"
        ReleaseNotes = "https://github.com/Xonshiz/comic-dl/releases/tag/$version"
    }
}
function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix
}

Update-Package -ChecksumFor None