import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1"   = @{
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum)'"
        }
    }
}

function global:au_GetLatest {
    $response    = Invoke-WebRequest -UseBasicParsing -Uri 'https://kcc.iosphe.re/Windows/'
    $file_name   = ([regex]::Match($response.Headers.'Content-Disposition', 'filename=(.*\.exe)')).Groups[1].Value
    $version     = ([regex]::Match($file_name, '(\d+\.\d+(\.\d+)*)\.exe')).Groups[1].Value
    [System.IO.File]::WriteAllBytes("$(pwd | select -exp Path)\$file_name", $response.Content)

    $checksum    = (Get-FileHash $file_name -Algorithm SHA256).Hash
    Remove-Item $file_name -Force

    @{
        Checksum = $checksum
        Version  = $version
    }
}

update
