import-module chocolatey-au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(^[$]absUrl\s*=\s*)('.*')"   = "`$1'$($Latest.Url32)'"
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://visualgdb.com/download/'
    $absoluteUrl   = $download_page.Links | Where-Object href -match '-trial\.msi' | Select-Object -First 1 -expand href
    $urlEnding      = ([regex]::Match($absoluteUrl, 'https://sysprogs.com/getfile/(\d+/VisualGDB.*\.msi)')).Groups[1].Value
    $version       = ([regex]::Match($absoluteUrl, '/VisualGDB-(\d+\.\d+(\.\d+)*(r\d+)?)-trial\.msi')).Groups[1].Value
    $versionChoco  = $version.Replace('r', '.')
    @{
        Version      = $versionChoco
        Url32        = "http://eu.cdn.sysprogs.com/$urlEnding"
    }
}

Update-Package -ChecksumFor 32
