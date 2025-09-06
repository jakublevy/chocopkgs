import-module chocolatey-au
. $([System.IO.Path]::Combine((Split-Path -Parent $PSScriptRoot), '.scripts', 'Get-GithubLatestReleaseLinks.ps1'))


function global:au_SearchReplace {
    @{
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+Go to).*"          = "`${1} $($Latest.Url64)"
            "(?i)(\s+checksum64:).*"    = "`${1} $($Latest.Checksum64)"
        }
        ".\gomuks.nuspec" = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $rel = (Get-GitHubLatestReleaseLinks -user 'tulir' -repository 'gomuks').Links | % href
    $relative_url  = $rel | Where-Object { $_ -match '/tulir/gomuks/releases/download/v\d+\.\d+(\.\d+)*/gomuks-windows-amd64\.exe' } | Select-Object -First 1
    if($null -eq $relative_url) {
        $version = '0.3.0'
    }
    else {
    $version = ([regex]::Match($relative_url, 'v(\d+\.\d+(\.\d+)*)')).Groups[1].Value
    }
    @{
        Version      = $version
        Url64        = "https://github.com/tulir/gomuks/releases/download/v$version/gomuks-windows-amd64.exe"
        ReleaseNotes = "https://github.com/tulir/gomuks/releases/tag/v$version"
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -NoSuffix -Purge
}

Update-Package -ChecksumFor None
