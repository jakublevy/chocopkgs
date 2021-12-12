import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(^[$]version\s*=\s*)('.*')"    = "`$1'$($Latest.Version)'"
            "(^[$]checksumEn\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumJp\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://www.systemax.jp/en/sai/'
    $links = $download_page.links | ? href -match '\.exe' | Select-Object -first 1 -exp href
    $version = [regex]::Match($links, '-(\d+\.\d+(\.\d+)*)-').Groups[1].Value
    @{
        Url32        = "https://www.systemax.jp/bin/sai-$version-ful-en.exe"
        Url64        = "https://www.systemax.jp/bin/sai-$version-ful-ja.exe" #Japanese version
        Version      = $version
    }
}



Update-Package
