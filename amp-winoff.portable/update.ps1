import-module au

function global:au_SearchReplace {
    $url = 'http://www.ampsoft.net/files/WinOFF.zip'
    Invoke-WebRequest -Uri $url -OutFile '_amp-winoff.zip'
    $checksum = (Get-FileHash '_amp-winoff.zip' -Algorithm SHA256).Hash
    Remove-Item '_amp-winoff.zip' -Force

    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$checksum'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'http://www.ampsoft.net/utilities/WinOFF.php'
    $version = [regex]::Match($download_page.Content, '<h1>AMP WinOFF (\d+\.\d+(\.\d+)*)</h1>').Groups[1]
    @{
        Version  = $version
    }
}

update
