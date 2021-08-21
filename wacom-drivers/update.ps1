import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(^[$]version\s*=\s*)('.*')"  = "`$1'$($Latest.Version)'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
        ".\wacom-drivers.nuspec"   = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://www.wacom.com/en-us/support/product-support/drivers#latest'
    $originalVersion = [regex]::Match($download_page.Content, 'Driver (\d+\.\d+(\.\d+)*(-\d+)?)').Groups[1].Value
    $chocoVersion = $originalVersion.Replace('-', '.')
    $versionAfterDashRemoved = $originalVersion.Split('-')[0]
    @{
        Url64        = "https://cdn.wacom.com/u/productsupport/drivers/win/professional/WacomTablet_$originalVersion.exe"
        Version      = $chocoVersion
        ReleaseNotes = "https://cdn.wacom.com/u/productsupport/drivers/win/professional/releasenotes/Windows_$versionAfterDashRemoved.html"
    }
}

Update-Package
