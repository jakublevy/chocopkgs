import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(^[$]archiveName\s*=\s*)('.*')"  = "`$1'$($Latest.FileName32)'"
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+Go to).*"           = "`${1} $($Latest.Url32)"
            "(?i)(\s+checksum32:).*"     = "`${1} $($Latest.Checksum32)"
        }
        ".\spicetify-marketplace.nuspec" = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://github.com/spicetify/spicetify-marketplace/releases'
    $relative_url  = $download_page.links | Where-Object href -match '/spicetify/spicetify-marketplace/archive/refs/tags/v\d+\.\d+(\.\d+)*(-alpha|-beta)?\.zip' | Select-Object -First 1 -expand href
    $version = ([regex]::Match($relative_url, 'v(\d+\.\d+(\.\d+)*(-alpha|-beta)?)')).Groups[1].Value
    @{
        Version      = $version.Split('-')[0]
        Url32        = "https://github.com/spicetify/spicetify-marketplace/releases/download/v$version/spicetify-marketplace-dist.zip"
        ReleaseNotes = "https://github.com/spicetify/spicetify-marketplace/releases/tag/v$version"
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -NoSuffix -Purge
}

Update-Package -ChecksumFor None
