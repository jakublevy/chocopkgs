import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(?i)(^\s*fileFullPath64\s*=\s*)(.*)" = "`${1}Join-Path `$toolsDir '$($Latest.FileName64)'"
        }
        ".\deadbeef.portable.nuspec"   = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+checksum64:).*"     = "`${1} $($Latest.Checksum64)"
            "(?i)(\s+Go to).*"           = "`${1} $($Latest.Url64)"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://sourceforge.net/projects/deadbeef/files/travis/windows/'
    $relative_urls  = $download_page.links | ? href -match ".*/\d+\.\d+(\.\d+)*/$" | select -exp href
    $versions = $relative_urls | % { ([regex]::Match($_, '.*/(\d+\.\d+(\.\d+)*)/$')).Groups[1].Value }
    $version = $versions | sort -Descending {[version] $_ } | select -First 1
    @{
        Url64        = "https://sourceforge.net/projects/deadbeef/files/travis/windows/$version/deadbeef-$version-windows-x86_64.zip"
        Version      = $version
        ReleaseNotes = "https://github.com/DeaDBeeF-Player/deadbeef/blob/$version/ChangeLog"
    }
}
function global:au_BeforeUpdate {
    Get-RemoteFiles -NoSuffix -Purge
}

Update-Package -ChecksumFor None
