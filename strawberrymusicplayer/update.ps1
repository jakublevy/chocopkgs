import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(?i)(^\s*file64\s*=\s*)(.*)"  = "`${1}Join-Path `$toolsDir '$($Latest.FileName64)'"
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+Go to).*"         = "`${1} $($Latest.Url64)"
            "(?i)(\s+checksum64:).*"   = "`${1} $($Latest.Checksum64)"
        }
        ".\strawberrymusicplayer.nuspec" = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://github.com/strawberrymusicplayer/strawberry/releases'
    $relative_url  = $download_page.links | Where-Object href -match '/strawberrymusicplayer/strawberry/releases/download/\d+\.\d+(\.\d+)*/StrawberrySetup-.*\.exe' | Select-Object -First 1 -expand href
    $version = ([regex]::Match($relative_url, '/(\d+\.\d+(\.\d+)*)/')).Groups[1].Value
    @{
        Version      = $version
        Url64        = "https://github.com/strawberrymusicplayer/strawberry/releases/download/$version/StrawberrySetup-$version-msvc-x64.exe"
        ReleaseNotes = "https://github.com/strawberrymusicplayer/strawberry/blob/$version/Changelog"
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -NoSuffix -Purge
}

Update-Package -ChecksumFor None
