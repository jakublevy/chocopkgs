import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^[$]version\s*=\s*)('.*')" = "`$1'$($Latest.Version)'"
        }
    }
}

function global:au_GetLatest {
    $response    = Invoke-WebRequest -UseBasicParsing -Uri 'https://www.proficad.com/download.aspx'
    $response    = $response.Content.Substring($response.Content.IndexOf('id="info'))
    $version     = ([regex]::Match($response, '(\d+\.\d+(\.\d+)*)')).Groups[1].Value
    @{
        Url32    = "https://www.proficad.com/down/$($version.Split('.')[0])/setup_full.exe"
        Version  = $version
    }
}

Update-Package
