import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(?i)(^\s*fileFullPath\s*=\s*)(.*)" = "`${1}Join-Path `$toolsDir '$($Latest.FileName32)'"
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+Go to).*"         = "`${1} $($Latest.Url32)"
            "(?i)(\s+checksum32:).*"   = "`${1} $($Latest.Checksum32)"
        }
        ".\undark.nuspec" = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://github.com/alitrack/undark/releases'
    $relative_url  = $download_page.links | Where-Object href -match '/alitrack/undark/releases/download/v\d+\.\d+(\.\d+)*/undark-win32-\d+\.\d+(\.\d+)*\.zip' | Select-Object -First 1 -expand href
    $version = ([regex]::Match($relative_url, 'undark-win32-(\d+\.\d+(\.\d+)*)\.zip')).Groups[1].Value
    @{
        Url32        = "https://github.com/alitrack/undark/releases/download/v$version/undark-win32-$version.zip"
        Version      = $version
        ReleaseNotes = "https://github.com/alitrack/undark/blob/v$version/CHANGELOG"
    }
}
function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix
}

Update-Package -ChecksumFor None