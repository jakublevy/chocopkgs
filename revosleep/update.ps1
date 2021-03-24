import-module au

function global:au_SearchReplace {
    $response64    = Invoke-WebRequest -UseBasicParsing -Uri $Latest.Url64
    $response      = Invoke-WebRequest -UseBasicParsing -Uri $Latest.Url
    [System.IO.File]::WriteAllBytes("$(pwd | select -exp Path)\$file_name64", $response64.Content)
    [System.IO.File]::WriteAllBytes("$(pwd | select -exp Path)\$file_name", $response.Content)
    $checksum64    = (Get-FileHash $file_name64 -Algorithm SHA256).Hash
    $checksum      = (Get-FileHash $file_name -Algorithm SHA256).Hash
    Remove-Item $file_name64 -Force
    Remove-Item $file_name -Force
    @{
        ".\tools\chocolateyinstall.ps1"     = @{
            "(^[$]checksum\s*=\s*)('.*')"   = "`$1'$checksum'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$checksum64'"
            "(^[$]version\s*=\s*)('.*')"    = "`$1'$($Latest.Version)'"
        }
    }
}

function global:au_GetLatest {
    $page          = Invoke-WebRequest -UseBasicParsing -Uri 'https://www.meinfach.net/revosleep/'
    $url64         = ($page.Links | Where-Object class -match "revoSleepx64" | Select-Object -First 1 -exp href) -Replace ';', '&'
    $url           = ($page.Links | Where-Object class -match "revoSleepx86" | Select-Object -First 1 -exp href) -Replace ';', '&'
    $file_name64   = ([regex]::Match($url64, '\?file=(.*\.zip).*')).Groups[1]
    $file_name     = ([regex]::Match($url, '\?file=(.*\.zip).*')).Groups[1]
    $version       = ([regex]::Match($file_name, 'v(\d+\.\d+(\.\d+)*)_.+.zip')).Groups[1].Value
    @{
        Checksum   = $checksum
        Checksum64 = $checksum64
        Version    = $version
        FileName   = $file_name
        FileName64 = $file_name64
        Url        = $url
        Url64      = $url64 
    }
}

update
