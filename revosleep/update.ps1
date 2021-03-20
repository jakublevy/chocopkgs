import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1"     = @{
            "(^[$]checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum)'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
            "(^[$]version\s*=\s*)('.*')"    = "`$1'$($Latest.Version)'"
        }
    }
}

function global:au_GetLatest {
    $page          = Invoke-WebRequest -UseBasicParsing -Uri 'https://www.meinfach.net/revosleep/'
    $url64         = ($page.Links | Where-Object class -match "revoSleepx64" | Select-Object -First 1 -exp href) -Replace ';', '&'
    $url           = ($page.Links | Where-Object class -match "revoSleepx86" | Select-Object -First 1 -exp href) -Replace ';', '&'
    $response64    = Invoke-WebRequest -UseBasicParsing -Uri $url64
    $response      = Invoke-WebRequest -UseBasicParsing -Uri $url

    $file_name64   = ([regex]::Match($url64, '\?file=(.*\.zip).*')).Groups[1]
    $file_name     = ([regex]::Match($url, '\?file=(.*\.zip).*')).Groups[1]
    $version       = ([regex]::Match($file_name, 'v(\d+\.\d+.\d+)_.+.zip')).Groups[1].Value
    [System.IO.File]::WriteAllBytes("$(pwd | select -exp Path)\$file_name64", $response64.Content)
    [System.IO.File]::WriteAllBytes("$(pwd | select -exp Path)\$file_name", $response.Content)

    $checksum64    = (Get-FileHash $file_name64 -Algorithm SHA256).Hash
    $checksum      = (Get-FileHash $file_name -Algorithm SHA256).Hash

    Remove-Item $file_name64 -Force
    Remove-Item $file_name -Force

    @{
        Checksum   = $checksum
        Checksum64 = $checksum64
        Version    = $version
    }
}

update
