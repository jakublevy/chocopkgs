import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]version\s*=\s*)('.*')"  = "`$1'$($Latest.Version)'"
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
        ".\anki.nuspec" = @{
            "(?i)(<releaseNotes>).*(</releaseNotes>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://apps.ankiweb.net/'

    $url = $download_page.links | Where-Object href -match 'https://github.com/ankitects/anki/releases/download/\d+\.\d+\.\d+/anki-\d+\.\d+\.\d+-windows.exe' | Select-Object -First 1 -expand href
    $version = ([regex]::Match($url, '(\d+\.\d+\.\d+)-windows.exe')).Groups[1].Value

    @{
        URL32        = $url
        Version      = $version
        ReleaseNotes = "https://github.com/ankitects/anki/releases/tag/$version"
    }
}

Update-Package -ChecksumFor 32