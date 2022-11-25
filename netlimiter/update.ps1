import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(^[$]version\s*=\s*)('.*')"  = "`$1'$($Latest.Version)'"
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
        ".\netlimiter.nuspec"   = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://www.netlimiter.com/download'
    $relative_url = $download_page.links | ? href -match '/download/nl/' | Select-Object -exp href | Select-Object -first 1
    $version = ([regex]::Match($relative_url, 'netlimiter-(\d+\.\d+(\.\d+)*)')).Groups[1].Value
    @{
        Url32        = "https://www.netlimiter.com/download/nl/netlimiter-$version.exe"
        Version      = $version
        ReleaseNotes = "https://www.netlimiter.com/releases/$($version -replace '\.', '-')"
    }
}



Update-Package -ChecksumFor 32
