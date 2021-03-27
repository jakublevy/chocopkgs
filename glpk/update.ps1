import-module au

# Release notes not fully automatic

function global:au_SearchReplace {
    $url = "https://sourceforge.net/projects/winglpk/files/winglpk/GLPK-$($Latest.Version)/winglpk-$($Latest.Version).zip"
    Invoke-WebRequest -Uri $url -OutFile '_glpk.zip'
    $checksum = (Get-FileHash '_glpk.zip' -Algorithm SHA256).Hash
    Remove-Item '_glpk.zip' -Force

    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(^[$]version\s*=\s*)('.*')"  = "`$1'$($Latest.Version)'"
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$checksum'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://sourceforge.net/projects/winglpk/files/winglpk/'

    $relative_urls  = $download_page.links | ? href -match '.*/GLPK-\d+\.\d+(\.\d+)*/$' | select -exp href
    $versions = $relative_urls | % { ([regex]::Match($_, '.*/GLPK-(\d+\.\d+(\.\d+)*)/$')).Groups[1].Value }
    $version = $versions | sort -Descending {[version] $_ } | select -First 1
    @{
        Version  = $version
    }
}

update
