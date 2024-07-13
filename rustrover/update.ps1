import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(^[$]version\s*=\s*)('.*')"  = "`$1'$($Latest.Version)'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $data = Invoke-WebRequest -UseBasicParsing -Uri 'https://data.services.jetbrains.com/products/releases?code=RR&latest=true&type=release' | ConvertFrom-Json
    $version = $data.RR[0].version
    $url64 = $data.RR[0].downloads.windows.link
    @{
        Url64           = $url64
        Version         = $version
    }
}

Update-Package -ChecksumFor 64
