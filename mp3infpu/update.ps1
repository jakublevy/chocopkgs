import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(?i)(^\s*file\s*=\s*)(.*)"    = "`${1}Join-Path `$toolsDir '$($Latest.FileName32)'"
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+Go to).*"           = "`${1} $($Latest.Url32)"
            "(?i)(\s+checksum32:).*"   = "`${1} $($Latest.Checksum32)"
        }
        ".\mp3infpu.nuspec" = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://github.com/k-takata/mp3infp/releases'
    $relative_url  = $download_page.links | Where-Object href -match '/k-takata/mp3infp/releases/download/mp3infp_u_\d+\.\d+(\.\d+)*/mp3infpu.*\.exe' | Select-Object -First 1 -expand href
    $version = ([regex]::Match($relative_url, '/mp3infp_u_(\d+\.\d+(\.\d+)*)/')).Groups[1].Value
    $versionInFileName = $version.ToString().Replace('.', '')
    @{
        Version      = $version
        Url32        = "https://github.com/k-takata/mp3infp/releases/download/mp3infp_u_$version/mp3infpu$versionInFileName.exe"
        ReleaseNotes = "https://github.com/k-takata/mp3infp/releases/tag/mp3infp_u_$version"
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -NoSuffix -Purge
}

Update-Package -ChecksumFor None
