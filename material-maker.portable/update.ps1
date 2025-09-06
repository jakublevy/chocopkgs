import-module chocolatey-au
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
        ".\material-maker.portable.nuspec" = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $rel = (Get-GitHubLatestReleaseLinks -user 'RodZill4' -repository 'material-maker').Links | % href
    $relative_url  = $rel | Where-Object { $_ -match '/RodZill4/material-maker/releases/download/\d+\.\d+(\.\d+)*(p\d+)?/.*windows\.zip' } | Select-Object -First 1
    $version_original = ([regex]::Match($relative_url, '(\d+\.\d+(\.\d+)*(p\d+)?)')).Groups[1].Value
    $version = $version_original -replace 'p', '.'
    $file_name = ([regex]::Match($relative_url, '/(material[^/]+windows\.zip)')).Groups[1].Value
    @{
        Version      = $version
        Url64        = "https://github.com/RodZill4/material-maker/releases/download/$version_original/$file_name"
        ReleaseNotes = "https://github.com/RodZill4/material-maker/releases/tag/$version_original"
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -NoSuffix -Purge
}

Update-Package -ChecksumFor None
