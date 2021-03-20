import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1"   = @{
            "(^[$]version\s*=\s*)('.*')"  = "`$1'$($Latest.Version)'"
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://github.com/lptstr/winfetch/releases/'
    $relative_url  = $download_page.links | Where-Object href -match '/lptstr/winfetch/archive/refs/tags/v\d+\.\d+\.\d+\.zip' | Select-Object -First 1 -expand href
    $version = ([regex]::Match($relative_url, '(\d+\.\d+\.\d+)\.zip')).Groups[1].Value

    Invoke-WebRequest -UseBasicParsing "https://github.com$relative_url" -OutFile '_winfetch.zip'
    $checksum = (Get-FileHash '_winfetch.zip' -Algorithm SHA256).Hash
    Remove-Item '_winfetch.zip' -Force

    @{
        Version  = $version
        Checksum = $checksum
    }
}

update
