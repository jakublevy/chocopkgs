import-module au

function global:au_SearchReplace {
    @{  ".\deadbeef.nuspec" = @{
            "(?i)(\<dependency id=""deadbeef.install"" version=""\[).*(""\] /\>)" = "`${1}$($Latest.Version)`${2}"
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://sourceforge.net/projects/deadbeef/files/travis/windows/'
    $relative_urls  = $download_page.links | ? href -match ".*/\d+\.\d+(\.\d+)*/$" | select -exp href
    $versions = $relative_urls | % { ([regex]::Match($_, '.*/(\d+\.\d+(\.\d+)*)/$')).Groups[1].Value }
    $version = $versions | sort -Descending {[version] $_ } | select -First 1
    @{
        Version  = $version
        ReleaseNotes = "https://github.com/DeaDBeeF-Player/deadbeef/blob/$version/ChangeLog"
    }
}

Update-Package -ChecksumFor None
