import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]version\s*=\s*)('.*')"  = "`$1'$($Latest.Version)'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
        ".\filen-sync.nuspec" = @{
            "(?i)(<releaseNotes>).*(</releaseNotes>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://github.com/FilenCloudDienste/filen-desktop/releases/'

    $relative_url = $download_page.links | Where-Object href -match '/FilenCloudDienste/filen-desktop/releases/download/\d+\.\d+(\.\d+)*/filen-setup.exe' | Select-Object -First 1 -expand href
    $version = ([regex]::Match($relative_url, '(\d+\.\d+(\.\d+)*)')).Groups[1].Value

    @{
        Url64        = "https://github.com/FilenCloudDienste/filen-desktop/releases/download/$version/filen-setup.exe"
        Version      = $version
        ReleaseNotes = "https://github.com/FilenCloudDienste/filen-desktop/releases/tag/$version"
    }
}

Update-Package -ChecksumFor 64