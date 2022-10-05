import-module au
. $([System.IO.Path]::Combine((Split-Path -Parent $PSScriptRoot), '.scripts', 'Get-GithubLatestReleaseLinks.ps1'))


function global:au_SearchReplace {
    @{
        ".\material-maker.nuspec" = @{
            "(?i)(<dependency id=""material-maker.portable"" version=""\[).*(\]"" />)" = "`${1}$($Latest.Version)`${2}"
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $rel = (Get-GitHubLatestReleaseLinks -user 'RodZill4' -repository 'material-maker').Links | % href
    $relative_url  = $rel | Where-Object { $_ -match '/RodZill4/material-maker/releases/download/\d+\.\d+(\.\d+)*/.*windows\.zip' } | Select-Object -First 1
    $version = ([regex]::Match($relative_url, '(\d+\.\d+(\.\d+)*)')).Groups[1].Value
    @{
        Version      = $version
        ReleaseNotes = "https://github.com/RodZill4/material-maker/releases/tag/$version"
    }
}

Update-Package -ChecksumFor None