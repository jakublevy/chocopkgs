import-module chocolatey-au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(?i)(^\s*fileFullPath64\s*=\s*)(.*)" = "`${1}Join-Path `$toolsDir '$($Latest.FileName64)'"
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+Go to).*"         = "`${1} $($Latest.Url64)"
            "(?i)(\s+checksum64:).*"   = "`${1} $($Latest.Checksum64)"
        }
        ".\dualiza.nuspec" = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $response = Invoke-WebRequest -UseBasicParsing -Uri 'https://raw.githubusercontent.com/arminbiere/dualiza/master/VERSION'
    $version = $response.Content.Trim()
    @{
        Url64        = "https://github.com/jakublevy/dualiza/releases/download/v$version/dualiza-$version-win-x64.zip"
        Version      = $version
        ReleaseNotes = "https://github.com/jakublevy/dualiza/releases/tag/v$version"
    }
}
function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix
}

Update-Package -ChecksumFor None