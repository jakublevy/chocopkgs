import-module au
. $([System.IO.Path]::Combine((Split-Path -Parent $PSScriptRoot), '.scripts', 'Get-GithubLatestReleaseLinks.ps1'))


function global:au_SearchReplace {
    @{
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+x86:).*"          = "`${1} $($Latest.Url32)"
            "(?i)(\s+x64:).*"          = "`${1} $($Latest.Url64)"
            "(?i)(\s+checksum32:).*"   = "`${1} $($Latest.Checksum32)"
            "(?i)(\s+checksum64:).*"   = "`${1} $($Latest.Checksum64)"
        }
        ".\sshs.nuspec" = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $rel = (Get-GitHubLatestReleaseLinks -user 'quantumsheep' -repository 'sshs').Links | % href
    $relative_url  = $rel | Where-Object { $_ -match '/quantumsheep/sshs/releases/download/\d+\.\d+(\.\d+)*/sshs-windows-amd64\.exe' } | Select-Object -First 1
    $version = ([regex]::Match($relative_url, '/(\d+\.\d+(\.\d+)*)/')).Groups[1].Value
    @{
        Url32        = "https://github.com/quantumsheep/sshs/releases/download/$version/sshs-windows-386.exe"
        Url64        = "https://github.com/quantumsheep/sshs/releases/download/$version/sshs-windows-amd64.exe"
        Version      = $version
        ReleaseNotes = "https://github.com/quantumsheep/sshs/releases/tag/v$version"
    }
}
function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix
}

Update-Package -ChecksumFor None