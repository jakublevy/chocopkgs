import-module au

function global:au_SearchReplace {
    @{
        ".\winfetch.nuspec" = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }

        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+Go to).*"         = "`${1} $($Latest.Url32)"
            "(?i)(\s+checksum32:).*"   = "`${1} $($Latest.Checksum32)"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://github.com/kiedtl/winfetch/releases/'
    $relative_url  = $download_page.links | Where-Object href -match '/kiedtl/winfetch/archive/refs/tags/v\d+\.\d+(\.\d+)*\.zip' | Select-Object -First 1 -expand href
    $version = ([regex]::Match($relative_url, '(\d+\.\d+(\.\d+)*)\.zip')).Groups[1].Value
    @{
        Version      = $version
        Url32        = "https://raw.githubusercontent.com/kiedtl/winfetch/v$version/winfetch.ps1"
        ReleaseNotes = "https://github.com/kiedtl/winfetch/releases/tag/v$version"
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -NoSuffix
}

Update-Package -ChecksumFor None
