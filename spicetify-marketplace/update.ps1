import-module chocolatey-au
. $([System.IO.Path]::Combine((Split-Path -Parent $PSScriptRoot), '.scripts', 'Get-GithubLatestReleaseLinks.ps1'))


function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(^[$]archiveName\s*=\s*)('.*')"  = "`$1'$($Latest.FileName32)'"
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+Go to).*"           = "`${1} $($Latest.Url32)"
            "(?i)(\s+checksum32:).*"     = "`${1} $($Latest.Checksum32)"
        }
        ".\spicetify-marketplace.nuspec" = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $rel = (Get-GitHubLatestReleaseLinks -user 'spicetify' -repository 'marketplace').Links | % href
    $relative_url  = $rel | Where-Object { $_ -match '/spicetify/marketplace/releases/download/v\d+\.\d+(\.\d+)*(-alpha|-beta)?' } | Select-Object -First 1
    $version = ([regex]::Match($relative_url, 'v(\d+\.\d+(\.\d+)*(-alpha|-beta)?)')).Groups[1].Value
    @{
        Version      = $version.Split('-')[0]
        Url32        = "https://github.com/spicetify/marketplace/releases/download/v$version/spicetify-marketplace.zip"
        ReleaseNotes = "https://github.com/spicetify/marketplace/releases/tag/v$version"
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -NoSuffix -Purge
}

Update-Package -ChecksumFor None
