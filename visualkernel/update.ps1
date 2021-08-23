import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(^[$]absUrl\s*=\s*)('.*')"  = "`$1'$($Latest.Url32)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://sysprogs.com/VisualKernel/download'
    $absoluteUrl   = $download_page.Links | Where-Object href -match '-trial\.msi' | Select-Object -First 1 -expand href
    $version       = ([regex]::Match($absoluteUrl, '/VisualKernel-(\d+\.\d+(\.\d+)*(r\d+)?)-trial\.msi')).Groups[1].Value
    $versionChoco  = $version.Replace('r', '.')
    @{
        Version      = $versionChoco
        Url32        = $absoluteUrl
    }
}

Update-Package
