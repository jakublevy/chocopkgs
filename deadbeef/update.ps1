import-module au

function global:au_SearchReplace {
    @{  
        ".\deadbeef.nuspec" = @{
            "(?i)(<dependency id=""deadbeef.install"" version=""\[).*(\]"" />)" = "`${1}$($Latest.Version)`${2}"
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://sourceforge.net/projects/deadbeef/files/travis/windows/'
    $relative_urls  = $download_page.links | ? href -match ".*/\d+\.\d+(\.\d+)*/$" | Select-Object -exp href
    $versions = $relative_urls | % { ([regex]::Match($_, '.*/(\d+\.\d+(\.\d+)*)/$')).Groups[1].Value }
    $version = $versions | Sort-Object -Descending {[version] $_ } | Select-Object -First 1
    $files_page = Invoke-WebRequest -UseBasicParsing -Uri "https://sourceforge.net/projects/deadbeef/files/travis/windows/$version"
    $matched_files = $files_page.links | ? href -match "deadbeef-$version(\.0)?-windows-x86_64\.exe"
    if(-not $matched_files) {
        $version = $versions | Sort-Object -Descending {[version] $_ } | Select-Object -First 2 | Select-Object -Last 1
    }
    @{
        Version  = $version
        ReleaseNotes = "https://github.com/DeaDBeeF-Player/deadbeef/blob/$version/ChangeLog"
    }
}

Update-Package -ChecksumFor None
