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
        ".\r128gain.nuspec" = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $rel = (Get-GitHubLatestReleaseLinks -user 'desbma' -repository 'r128gain').Links | % href
    $relative_url  = $rel | Where-Object { $_ -match '/desbma/r128gain/releases/download/\d+\.\d+(\.\d+)*/r128gain_win64\.7z' } | Select-Object -First 1
    $version = ([regex]::Match($relative_url, '/(\d+\.\d+(\.\d+)*)/')).Groups[1].Value
    @{
        Version      = $version
        Url32        = "https://github.com/desbma/r128gain/releases/download/$version/r128gain_win32.7z"
        Url64        = "https://github.com/desbma/r128gain/releases/download/$version/r128gain_win64.7z"
        ReleaseNotes = "https://github.com/desbma/r128gain/releases/tag/$version"
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -NoSuffix -Purge
}

Update-Package -ChecksumFor None
