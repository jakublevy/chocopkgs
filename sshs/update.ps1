import-module au

function global:au_SearchReplace {
    @{
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+Go to).*"         = "`${1} $($Latest.Url64)"
            "(?i)(\s+checksum64:).*"   = "`${1} $($Latest.Checksum64)"
        }
        ".\sshs.nuspec" = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://github.com/quantumsheep/sshs/releases'
    $relative_url  = $download_page.links | Where-Object href -match '/quantumsheep/sshs/releases/download/\d+\.\d+(\.\d+)*/sshs-windows-amd64\.exe' | Select-Object -First 1 -expand href
    $version = ([regex]::Match($relative_url, '/(\d+\.\d+(\.\d+)*)/')).Groups[1].Value
    @{
        Url64        = "https://github.com/quantumsheep/sshs/releases/download/$version/sshs-windows-amd64.exe"
        Version      = $version
        ReleaseNotes = "https://github.com/quantumsheep/sshs/releases/tag/v$version"
    }
}
function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix
}

Update-Package -ChecksumFor None