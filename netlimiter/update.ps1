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
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://www.netlimiter.com/'
    $version = $download_page.links | ? href -match '/releases/' | select -exp href | % { ($_ -split '/')[3] -replace '-', '.' } | select -first 1
    @{
        Url32        = "https://www.netlimiter.com/files/download/nl4/netlimiter-$version.exe"
        Version      = $version
        ReleaseNotes = "https://www.netlimiter.com/releases/nl4/$($version -replace '\.', '-')"
    }
}

Update-Package
