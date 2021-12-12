import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(?i)(^\s*file\s*=\s*)(.*)"  = "`${1}Join-Path `$toolsDir '$($Latest.FileName32)'"
            "(?i)(^\s*file64\s*=\s*)(.*)"  = "`${1}Join-Path `$toolsDir '$($Latest.FileName64)'"
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+x86:).*"          = "`${1} $($Latest.Url32)"
            "(?i)(\s+x64:).*"          = "`${1} $($Latest.Url64)"
            "(?i)(\s+checksum32:).*"   = "`${1} $($Latest.Checksum32)"
            "(?i)(\s+checksum64:).*"   = "`${1} $($Latest.Checksum64)"
        }
        ".\scantailor-advanced.nuspec" = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://github.com/4lex4/scantailor-advanced/releases'
    $relative_url  = $download_page.links | Where-Object href -match '/4lex4/scantailor-advanced/releases/download/\d+\.\d+(\.\d+)*(_EA)?/scantailor-advanced-\d+\.\d+(\.\d+)*-win64\.exe' | Select-Object -First 1 -expand href
    $versionOriginal = ([regex]::Match($relative_url, '/(\d+\.\d+(\.\d+)*(_EA)?)/')).Groups[1].Value
    $version = ([regex]::Match($versionOriginal, '(\d+\.\d+(\.\d+)*)')).Groups[1].Value
    @{
        Version      = $version
        Url32        = "https://github.com/4lex4/scantailor-advanced/releases/download/$versionOriginal/scantailor-advanced-$version-win32.exe"
        Url64        = "https://github.com/4lex4/scantailor-advanced/releases/download/$versionOriginal/scantailor-advanced-$version-win64.exe"
        ReleaseNotes = "https://github.com/4lex4/scantailor-advanced/releases/tag/$versionOriginal"
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -NoSuffix -Purge
}

Update-Package -ChecksumFor None
