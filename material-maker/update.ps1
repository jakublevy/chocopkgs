import-module au

function global:au_SearchReplace {
    @{
        ".\material-maker.nuspec" = @{
            "(?i)(\<dependency id=""material-maker.portable"" version=""\[).*(""\] /\>)" = "`${1}$($Latest.Version)`${2}"
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://github.com/RodZill4/material-maker/releases'
    $relative_url  = $download_page.links | Where-Object href -match '/RodZill4/material-maker/releases/download/\d+\.\d+(\.\d+)*/.*windows\.zip' | Select-Object -First 1 -expand href
    $version = ([regex]::Match($relative_url, '(\d+\.\d+(\.\d+)*)')).Groups[1].Value
    @{
        Version      = $version
        ReleaseNotes = "https://github.com/RodZill4/material-maker/releases/tag/$version"
    }
}

Update-Package -ChecksumFor None