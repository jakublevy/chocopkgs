import-module au

function global:au_SearchReplace {
    Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/lptstr/winfetch/v$($Latest.Version)/winfetch.ps1" -OutFile '_winfetch.ps1'
    $checksum = (Get-FileHash '_winfetch.ps1' -Algorithm SHA256).Hash
    Remove-Item '_winfetch.ps1' -Force

    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(^[$]version\s*=\s*)('.*')"  = "`$1'$($Latest.Version)'"
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$checksum'"
        }
        ".\winfetch.nuspec"   = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://github.com/lptstr/winfetch/releases/'
    $relative_url  = $download_page.links | Where-Object href -match '/lptstr/winfetch/archive/refs/tags/v\d+\.\d+(\.\d+)*\.zip' | Select-Object -First 1 -expand href
    $version = ([regex]::Match($relative_url, '(\d+\.\d+(\.\d+)*)\.zip')).Groups[1].Value
    @{
        Version      = $version
        ReleaseNotes = "https://github.com/lptstr/winfetch/releases/tag/v$version"
    }
}

update
