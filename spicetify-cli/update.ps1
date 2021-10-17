import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(?i)(^\s*fileFullPath\s*=\s*)(.*)"    = "`${1}Join-Path `$toolsDir '$($Latest.FileName32)'"
            "(?i)(^\s*fileFullPath64\s*=\s*)(.*)"  = "`${1}Join-Path `$toolsDir '$($Latest.FileName64)'"
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+x86:).*"          = "`${1} $($Latest.Url32)"
            "(?i)(\s+x64:).*"          = "`${1} $($Latest.Url64)"
            "(?i)(\s+checksum32:).*"   = "`${1} $($Latest.Checksum32)"
            "(?i)(\s+checksum64:).*"   = "`${1} $($Latest.Checksum64)"
        }
        ".\spicetify-cli.nuspec" = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://github.com/khanhas/spicetify-cli/releases'
    $relative_url  = $download_page.links | Where-Object href -match '/khanhas/spicetify-cli/releases/download/v\d+\.\d+(\.\d+)*/spicetify-\d+\.\d+(\.\d+)*-windows-x64\.zip' | Select-Object -First 1 -expand href
    $version = ([regex]::Match($relative_url, 'v(\d+\.\d+(\.\d+)*)')).Groups[1].Value
    @{
        Version      = $version
        Url32        = "https://github.com/khanhas/spicetify-cli/releases/download/v$version/spicetify-$version-windows-x32.zip"
        Url64        = "https://github.com/khanhas/spicetify-cli/releases/download/v$version/spicetify-$version-windows-x64.zip"
        ReleaseNotes = "https://github.com/khanhas/spicetify-cli/releases/tag/v$version"
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -NoSuffix -Purge
}

function global:au_AfterUpdate($pkg) {
    Set-DescriptionFromReadme $pkg
}

Update-Package -ChecksumFor None
