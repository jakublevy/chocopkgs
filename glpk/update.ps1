import-module au

# Release notes not fully automatic

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(?i)(^\s*fileFullPath\s*=\s*)(.*)" = "`${1}Join-Path `$toolsDir '$($Latest.FileName32)'"
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+Go to).*"         = "`${1} $($Latest.Url32)"
            "(?i)(\s+checksum32:).*"     = "`${1} $($Latest.Checksum32)"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://sourceforge.net/projects/winglpk/files/winglpk/'

    $relative_urls  = $download_page.links | ? href -match '.*/GLPK-\d+\.\d+(\.\d+)*/$' | select -exp href
    $versions = $relative_urls | % { ([regex]::Match($_, '.*/GLPK-(\d+\.\d+(\.\d+)*)/$')).Groups[1].Value }
    $version = $versions | sort -Descending {[version] $_ } | select -First 1
    @{
        Url32    = "https://sourceforge.net/projects/winglpk/files/winglpk/GLPK-$version/winglpk-$version.zip"
        Version  = $version
    }
}
function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix
}

Update-Package -ChecksumFor None