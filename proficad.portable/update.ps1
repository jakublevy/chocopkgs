import-module au

function global:au_SearchReplace {
    Invoke-WebRequest -UseBasicParsing -Uri "https://www.proficad.com/down/$($Latest.Version.Split('.')[0])/proficad_portable_en.zip" -OutFile '_proficad.zip'
    $checksum = (Get-FileHash '_proficad.zip' -Algorithm SHA256).Hash
    Remove-Item '_proficad.zip' -Force

    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$checksum'"
            "(^[$]version\s*=\s*)('.*')" = "`$1'$($Latest.Version)'"
        }
    }
}

function global:au_GetLatest {
    $response    = Invoke-WebRequest -UseBasicParsing -Uri 'https://www.proficad.com/CAD-USB-drive.aspx'
    $response    = $response.Content.Substring($response.Content.IndexOf('id="info'))
    $version     = ([regex]::Match($response, '(\d+\.\d+(\.\d+)*)')).Groups[1].Value
    @{
        Version  = $version
    }
}

update
