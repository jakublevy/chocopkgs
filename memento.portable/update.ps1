import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(?i)(^\s*fileFullPath64\s*=\s*)(.*)" = "`${1}Join-Path `$toolsDir '$($Latest.FileName64)'"
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+Go to).*"         = "`${1} $($Latest.Url64)"
            "(?i)(\s+checksum64:).*"   = "`${1} $($Latest.Checksum64)"
        }
        ".\memento.portable.nuspec" = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://github.com/ripose-jp/Memento/releases'
    $relative_url  = $download_page.links | Where-Object href -match '/ripose-jp/Memento/releases/download/v\d+\.\d+(\.\d+)*(-\d+)?(-beta)?/Memento_Windows_x86_64.zip' | Select-Object -First 1 -expand href
    $versionFull = ([regex]::Match($relative_url, '/download/v(\d+\.\d+(\.\d+)*(-\d+)?(-beta)?)/Memento_Windows_x86_64.zip')).Groups[1].Value
    $version = ([regex]::Match($relative_url, '(\d+\.\d+(\.\d+)*(-\d+)?)(-beta)?')).Groups[1].Value
    $version = $version.Replace('-', '.')
    @{
        Url64        = "https://github.com/ripose-jp/Memento/releases/download/v$versionFull/Memento_Windows_x86_64.zip"
        Version      = $version
        ReleaseNotes = "https://github.com/ripose-jp/Memento/releases/tag/v$versionFull"
    }
}
function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix
}

Update-Package -ChecksumFor None