import-module au

function global:au_SearchReplace {
    Invoke-WebRequest -UseBasicParsing -Uri 'https://kcc.iosphe.re/Windows/' -OutFile '_kcc.exe'
    $checksum64 = (Get-FileHash '_kcc.exe' -Algorithm SHA256).Hash
    Remove-Item '_kcc.exe' -Force

    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$checksum64'"
        }
        ".\kindle-comic-converter.nuspec"   = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $response    = Invoke-WebRequest -UseBasicParsing -Uri 'https://kcc.iosphe.re/Windows/' -Method Head
    $file_name   = ([regex]::Match($response.Headers.'Content-Disposition', 'filename=(.*\.exe)')).Groups[1].Value
    $version     = ([regex]::Match($file_name, '(\d+\.\d+(\.\d+)*)\.exe')).Groups[1].Value
    @{
        Version  = $version
        ReleaseNotes = "https://github.com/ciromattia/kcc/blob/$version/CHANGELOG.md"
    }
}

update
