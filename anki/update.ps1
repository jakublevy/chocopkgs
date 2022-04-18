import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(?i)(^\s*file\s*=\s*)(.*)"   = "`${1}Join-Path `$toolsDir '$($Latest.FileName32)'"
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+Go to).*"         = "`${1} $($Latest.Url32)"
            "(?i)(\s+checksum32:).*"   = "`${1} $($Latest.Checksum32)"
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
        Version      = $version
        ReleaseNotes = "https://github.com/ankitects/anki/releases/tag/$version"
    }
}
function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix
}

Update-Package -ChecksumFor None