import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(?i)(^\s*fileFullPath\s*=\s*)(.*)"    = "`${1}Join-Path `$toolsDir '$($Latest.FileName32)'"
            "(?i)(^\s*fileFullPath64\s*=\s*)(.*)"  = "`${1}Join-Path `$toolsDir '$($Latest.FileName64)'"
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+x86:).*"          = "`${1} $($Latest.Url32)"
            "(?i)(\s+x64:).*"          = "`${1} $($Latest.Url64)"
            "(?i)(\s+checksum32:).*"   = "`${1} $($Latest.Checksum32)"
            "(?i)(\s+checksum64:).*"   = "`${1} $($Latest.Checksum64)"
        }
        ".\adreports.nuspec" = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://github.com/brechtsanders/ADReports/releases'
    $relative_url  = $download_page.links | Where-Object href -match '/brechtsanders/ADReports/releases/download/\d+\.\d+(\.\d+)*/adreports-\d+\.\d+(\.\d+)*-win64\.zip' | Select-Object -First 1 -expand href
    $version     = ([regex]::Match($relative_url, '/adreports-(\d+\.\d+(\.\d+)*)-win64\.zip')).Groups[1].Value
    @{
        Version      = $version
        Url32        = "https://github.com/brechtsanders/ADReports/releases/download/$version/adreports-$version-win32.zip"
        Url64        = "https://github.com/brechtsanders/ADReports/releases/download/$version/adreports-$version-win64.zip"
        ReleaseNotes = "https://github.com/brechtsanders/ADReports/releases/tag/$version"
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -NoSuffix -Purge
}

Update-Package -ChecksumFor None
