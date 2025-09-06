import-module chocolatey-au

function global:au_SearchReplace {
    @{
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+Go to).*"         = "`${1} $($Latest.Url32)"
            "(?i)(\s+checksum32:).*"   = "`${1} $($Latest.Checksum32)"
        }
        ".\pdftk-java.nuspec" = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://gitlab.com/pdftk-java/pdftk/-/raw/master/CHANGELOG.md'
    $download_links = Invoke-WebRequest -UseBasicParsing -Uri 'https://gitlab.com/pdftk-java/pdftk/-/raw/master/README.md'
    $version = ([regex]::Match($download_page.Content, '\[(\d+\.\d+(\.\d+)*)\]')).Groups[1].Value
    $download_link = ([regex]::Match($download_links.Content, "(https://gitlab.com/api/v4/projects/\d+/packages/generic/pdftk-java/v$version/pdftk-all.jar)")).Groups[1].Value
    @{
        Url32        = $download_link
        Version      = $version
        ReleaseNotes = "https://gitlab.com/pdftk-java/pdftk/-/blob/v$version/CHANGELOG.md"
    }
}
function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix
}

Update-Package -ChecksumFor None