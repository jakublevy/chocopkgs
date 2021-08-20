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
        ".\tclocklight-kt.nuspec" = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://github.com/k-takata/TClockLight/releases'
    $relative_url  = $download_page.links | Where-Object href -match '/k-takata/TClockLight/releases/download/tclocklight-kt\d{6}/tclocklight-kt\d{6}-x64\.zip' | Select-Object -First 1 -expand href
    $versionOriginal = ([regex]::Match($relative_url, 'tclocklight-kt(\d{6})')).Groups[1].Value
    $version = $versionOriginal.ToString().Substring(0,2) + '.' + $versionOriginal.ToString().Substring(2,2) + '.' + $versionOriginal.ToString().Substring(4,2)
    @{
        Version      = $version
        Url32        = "https://github.com/k-takata/TClockLight/releases/download/tclocklight-kt$versionOriginal/tclocklight-kt$versionOriginal-x86.zip"
        Url64        = "https://github.com/k-takata/TClockLight/releases/download/tclocklight-kt$versionOriginal/tclocklight-kt$versionOriginal-x64.zip"
        ReleaseNotes = "https://github.com/k-takata/TClockLight/releases/tag/tclocklight-kt$versionOriginal"
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -NoSuffix -Purge
}

Update-Package -ChecksumFor None
