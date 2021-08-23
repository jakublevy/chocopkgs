import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(^[$]version\s*=\s*)('.*')"  = "`$1'$($Latest.Version)'"
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+Go to).*"           = "`${1} $($Latest.Url64)"
            "(?i)(\s+checksum64:).*"     = "`${1} $($Latest.Checksum64)"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://sysprogs.com/winflashtool/download/'
    $absoluteUrl  = $download_page.Links | Where-Object href -match 'WinFLASHTool-' | Select-Object -First 1 -expand href
    $version     = ([regex]::Match($absoluteUrl, '/WinFLASHTool-(\d+\.\d+(\.\d+)*)\.exe')).Groups[1].Value
    @{
        Version      = $version
        Url64        = $absoluteUrl
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -NoSuffix -Purge
}

Update-Package -ChecksumFor None
