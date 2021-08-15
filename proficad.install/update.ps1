import-module au

function global:au_SearchReplace {
    Invoke-WebRequest -UseBasicParsing -Uri "https://www.proficad.com/down/$($Latest.Version.Split('.')[0])/setup_full.exe" -OutFile '_proficad.exe'
    $checksum = (Get-FileHash '_proficad.exe' -Algorithm SHA256).Hash
    Remove-Item '_proficad.exe' -Force

    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$checksum'"
            "(^[$]version\s*=\s*)('.*')" = "`$1'$($Latest.Version)'"
        }
    }
}

function global:au_GetLatest {
    $response    = Invoke-WebRequest -UseBasicParsing -Uri 'https://www.proficad.com/download.aspx'
    $response    = $response.Content.Substring($response.Content.IndexOf('id="info'))
    $version     = ([regex]::Match($response, '(\d+\.\d+(\.\d+)*)')).Groups[1].Value
    @{
        Version  = $version
    }
}

update
