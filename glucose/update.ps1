import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(?i)(^\s*fileFullPath64\s*=\s*)(.*)" = "`${1}Join-Path `$toolsDir '$($Latest.FileName64)'"
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+Go to).*"         = "`${1} $($Latest.Url64)"
            "(?i)(\s+checksum64:).*"   = "`${1} $($Latest.Checksum64)"
        }
        ".\glucose.nuspec" = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://www.labri.fr/perso/lsimon/glucose/'
    $links = $download_page.links | Where-Object href -match 'glucose' | select -exp href
    $versions = ([regex]::Matches($links, '(\d+\.\d+(\.\d+)*)')).Groups | ? success | select -exp value | Get-Unique
    $version = $versions | sort -Descending {[version] $_ } | select -First 1
    @{
        Url64        = "https://github.com/jakublevy/glucose-win/releases/download/v$version/glucose-$version-win-x64.zip"
        Version      = $version
        ReleaseNotes = "https://github.com/jakublevy/glucose-win/releases/tag/v$version"
    }
}
function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix
}

Update-Package -ChecksumFor None