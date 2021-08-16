import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"     = @{
            "(^[$]checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
            "(^[$]version\s*=\s*)('.*')"    = "`$1'$($Latest.Version)'"
        }
    }
}

function global:au_GetLatest {
    $page          = Invoke-WebRequest -UseBasicParsing -Uri 'https://www.meinfach.net/revosleep/'
    $url64         = ($page.Links | Where-Object class -match "revoSleepx64" | Select-Object -First 1 -exp href) -Replace ';', '&'
    $url           = ($page.Links | Where-Object class -match "revoSleepx86" | Select-Object -First 1 -exp href) -Replace ';', '&'
    $file_name     = ([regex]::Match($url, '\?file=(.*\.zip).*')).Groups[1]
    $version       = ([regex]::Match($file_name, 'v(\d+\.\d+(\.\d+)*)_.+.zip')).Groups[1].Value
    @{
        Version    = $version
        Url        = $url
        Url64      = $url64 
    }
}

function global:au_BeforeUpdate {
    Invoke-WebRequest -UseBasicParsing -Uri $Latest.Url64 -OutFile '_revosleep_64.zip'
    Invoke-WebRequest -UseBasicParsing -Uri $Latest.Url -OutFile '_revosleep_32.zip'
    $global:Latest.Checksum64 = (Get-FileHash '_revosleep_64.zip' -Algorithm SHA256).Hash
    $global:Latest.Checksum32 = (Get-FileHash '_revosleep_32.zip' -Algorithm SHA256).Hash
    Remove-Item '_revosleep_64.zip' -Force
    Remove-Item '_revosleep_32.zip' -Force
}

Update-Package -ChecksumFor None
