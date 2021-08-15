import-module au

function global:au_SearchReplace {
    $url64 = "https://sourceforge.net/projects/deadbeef/files/travis/windows/$($Latest.Version)/deadbeef-$($Latest.Version)-windows-x86_64.exe"
    Invoke-WebRequest -Uri $url64 -OutFile '_deadbeef.exe'
    $checksum64 = (Get-FileHash '_deadbeef.exe' -Algorithm SHA256).Hash
    Remove-Item '_deadbeef.exe' -Force

    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(^[$]version\s*=\s*)('.*')"  = "`$1'$($Latest.Version)'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$checksum64'"
        }
        ".\deadbeef.install.nuspec"   = @{
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

update
