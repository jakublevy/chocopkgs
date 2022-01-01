import-module au

function global:au_SearchReplace {
    @{
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+x86:).*"          = "`${1} $($Latest.Url32)"
            "(?i)(\s+x64:).*"          = "`${1} $($Latest.Url64)"
            "(?i)(\s+checksum32:).*"   = "`${1} $($Latest.Checksum32)"
            "(?i)(\s+checksum64:).*"   = "`${1} $($Latest.Checksum64)"
        }
        ".\rcedit.nuspec" = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://github.com/electron/rcedit/releases'
    $relative_url  = $download_page.links | Where-Object href -match '/electron/rcedit/releases/download/v\d+\.\d+(\.\d+)*/rcedit-x64\.exe' | Select-Object -First 1 -expand href
    $version = ([regex]::Match($relative_url, '/v(\d+\.\d+(\.\d+)*)/')).Groups[1].Value
    @{
        Version      = $version
        Url32        = "https://github.com/electron/rcedit/releases/download/v$version/rcedit-x86.exe"
        Url64        = "https://github.com/electron/rcedit/releases/download/v$version/rcedit-x64.exe"
        ReleaseNotes = "https://github.com/electron/rcedit/releases/tag/v$version"
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -NoSuffix -Purge
}

Update-Package -ChecksumFor None
