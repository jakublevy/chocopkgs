import-module au

function global:au_SearchReplace {
    @{
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+Go to).*"         = "`${1} $($Latest.Url64)"
            "(?i)(\s+checksum64:).*"   = "`${1} $($Latest.Checksum64)"
        }
        ".\ugrep.nuspec" = @{
            "(?i)(<releaseNotes>).*(</releaseNotes>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://github.com/Genivia/ugrep/releases'
    $relative_url  = $download_page.links | Where-Object href -match '/Genivia/ugrep/releases/download/v\d+\.\d+(\.\d+)*/ugrep\.exe' | Select-Object -First 1 -expand href
    $version = ([regex]::Match($relative_url, '/v(\d+\.\d+(\.\d+)*)/')).Groups[1].Value
    @{
        Url64        = "https://github.com/Genivia/ugrep/releases/download/v$version/ugrep.exe"
        Version      = $version
        ReleaseNotes = "https://github.com/Genivia/ugrep/releases/tag/v$version"
    }
}
function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix
}

Update-Package -ChecksumFor None -NoCheckChocoVersion