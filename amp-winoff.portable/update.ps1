import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'http://www.ampsoft.net/utilities/WinOFF.php'
    $version = [regex]::Match($download_page.Content, '<h1>AMP WinOFF (\d+\.\d+(\.\d+)*)</h1>').Groups[1]
    @{
        Url32    = 'http://www.ampsoft.net/files/WinOFF.zip'
        Version  = $version
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -NoSuffix -Purge
}

Update-Package -ChecksumFor None
