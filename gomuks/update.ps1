import-module au

function global:au_SearchReplace {
    @{
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+Go to).*"          = "`${1} $($Latest.Url64)"
            "(?i)(\s+checksum64:).*"    = "`${1} $($Latest.Checksum64)"
        }
        ".\gomuks.nuspec" = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://github.com/tulir/gomuks/releases'
    $relative_url  = $download_page.links | Where-Object href -match '/tulir/gomuks/releases/download/v\d+\.\d+(\.\d+)*/gomuks-windows-amd64\.exe' | Select-Object -First 1 -expand href
    $version = ([regex]::Match($relative_url, 'v(\d+\.\d+(\.\d+)*)')).Groups[1].Value
    @{
        Version      = $version
        Url64        = "https://github.com/tulir/gomuks/releases/download/v$version/gomuks-windows-amd64.exe"
        ReleaseNotes = "https://github.com/tulir/gomuks/releases/tag/v$version"
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -NoSuffix -Purge
}

function global:au_AfterUpdate($pkg) {
    Set-DescriptionFromReadme $pkg
}

Update-Package -ChecksumFor None
