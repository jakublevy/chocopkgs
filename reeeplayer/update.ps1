import-module au

function global:au_SearchReplace {
    @{
        ".\reeeplayer.nuspec"   = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
            "(?i)(\<dependency id=""reeeplayer.portable"" version=""\[).*(""\] /\>)" = "`${1}$($Latest.Version)`${2}"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://github.com/FilippVolodin/ReeePlayer/releases'
    $relative_url  = $download_page.links | Where-Object href -match '/FilippVolodin/ReeePlayer/releases/download/v\d+\.\d+(\.\d+)*/ReeePlayer-\d+\.\d+(\.\d+)*-win-x64\.zip' | Select-Object -First 1 -expand href
    $version = ([regex]::Match($relative_url, 'ReeePlayer-(\d+\.\d+(\.\d+)*)-win-x64\.zip')).Groups[1].Value
    @{
        Version      = $version
        ReleaseNotes = "https://github.com/FilippVolodin/ReeePlayer/releases/tag/v$version"
    }
}

Update-Package -ChecksumFor None
