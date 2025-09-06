import-module chocolatey-au
. $([System.IO.Path]::Combine((Split-Path -Parent $PSScriptRoot), '.scripts', 'Get-GithubLatestReleaseLinks.ps1'))


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
    $rel = (Get-GitHubLatestReleaseLinks -user '4lex4' -repository 'scantailor-advanced').Links | % href
    $relative_url  = $rel | Where-Object {$_ -match '/4lex4/scantailor-advanced/releases/tag/\d+\.\d+(\.\d+)*(_EA)?' } | Select-Object -First 1
    $versionOriginal = ([regex]::Match($relative_url, '/(\d+\.\d+(\.\d+)*(_EA)?)')).Groups[1].Value
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
