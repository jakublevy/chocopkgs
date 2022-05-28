import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(^[$]version\s*=\s*)('.*')"  = "`$1'$($Latest.Version)'"
            "(^[$]checksumQt5\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
            "(^[$]checksumQt6\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
        ".\anki.nuspec" = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://github.com/ankitects/anki/releases'
    $relative_url  = $download_page.links | Where-Object href -match '/ankitects/anki/releases/download/\d+\.\d+(\.\d+)*/anki-\d+\.\d+(\.\d+)*-windows-qt6\.exe' | Select-Object -First 1 -expand href
    $version = ([regex]::Match($relative_url, 'download/(\d+\.\d+(\.\d+)*)/anki-\d+\.\d+(\.\d+)*-windows-qt6\.exe')).Groups[1].Value
    @{
        Url32        = "https://github.com/ankitects/anki/releases/download/$version/anki-$version-windows-qt6.exe"
        Url64        = "https://github.com/ankitects/anki/releases/download/$version/anki-$version-windows-qt5.exe"
        Version      = $version
        ReleaseNotes = "https://github.com/ankitects/anki/releases/tag/$version"
    }
}

Update-Package