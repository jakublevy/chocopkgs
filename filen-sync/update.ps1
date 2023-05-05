import-module au
. $([System.IO.Path]::Combine((Split-Path -Parent $PSScriptRoot), '.scripts', 'Get-GithubLatestReleaseLinks.ps1'))


function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1" = @{
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
        ".\filen-sync.nuspec" = @{
            "(?i)(<releaseNotes>).*(</releaseNotes>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $rel = (Get-GitHubLatestReleaseLinks -user 'FilenCloudDienste' -repository 'filen-desktop').Links | % href
    $relative_url = $rel | Where-Object { $_ -match '/FilenCloudDienste/filen-desktop/archive/refs/tags/\d+\.\d+(\.\d+)*\.zip' } | Select-Object -First 1
    if($null -eq $relative_url) {
        $version = '2.0.16'
    }
    else {
        $version = ([regex]::Match($relative_url, '(\d+\.\d+(\.\d+)*)')).Groups[1].Value
    }

    @{
        Url64        = 'https://cdn.filen.io/desktop/release/filen_x64.exe'
        Version      = $version
        ReleaseNotes = "https://github.com/FilenCloudDienste/filen-desktop/releases/tag/$version"
    }
}

Update-Package -ChecksumFor 64