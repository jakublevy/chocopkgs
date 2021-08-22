import-module au

function global:au_SearchReplace {
    @{
        ".\memento.nuspec" = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
            "(?i)(\<dependency id=""memento.portable"" version=""\[).*(""\] /\>)" = "`${1}$($Latest.Version)`${2}"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://github.com/ripose-jp/Memento/releases'
    $relative_url  = $download_page.links | Where-Object href -match '/ripose-jp/Memento/releases/download/v\d+\.\d+(\.\d+)*(-\d+)?(-beta)?/Memento_Windows_x86_64\.zip' | Select-Object -First 1 -expand href
    $versionFull = ([regex]::Match($relative_url, '/download/v(\d+\.\d+(\.\d+)*(-\d+)?(-beta)?)/Memento_Windows_x86_64.zip')).Groups[1].Value
    $version = ([regex]::Match($relative_url, '(\d+\.\d+(\.\d+)*(-\d+)?)(-beta)?')).Groups[1].Value
    $version = $version.Replace('-', '.')
    @{
        Version      = $version
        ReleaseNotes = "https://github.com/ripose-jp/Memento/releases/tag/v$versionFull"
    }
}

Update-Package -ChecksumFor None