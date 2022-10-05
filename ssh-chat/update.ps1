import-module au
. $([System.IO.Path]::Combine((Split-Path -Parent $PSScriptRoot), '.scripts', 'Get-GithubLatestReleaseLinks.ps1'))


function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(?i)(^\s*fileFullPath\s*=\s*)(.*)" = "`${1}Join-Path `$toolsDir '$($Latest.FileName32)'"
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+Go to).*"         = "`${1} $($Latest.Url32)"
            "(?i)(\s+checksum32:).*"   = "`${1} $($Latest.Checksum32)"
        }
        ".\ssh-chat.nuspec" = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $rel = (Get-GitHubLatestReleaseLinks -user 'shazow' -repository 'ssh-chat').Links | % href
    $relative_url  = $rel | Where-Object { $_ -match '/shazow/ssh-chat/releases/download/v\d+\.\d+(\.\d+)*/ssh-chat-windows_386.tgz' } | Select-Object -First 1
    $version = ([regex]::Match($relative_url, '/releases/download/v(\d+\.\d+(\.\d+)*)/ssh-chat-windows_386.tgz')).Groups[1].Value
    @{
        Url32        = "https://github.com/shazow/ssh-chat/releases/download/v$version/ssh-chat-windows_386.tgz"
        Version      = $version
        ReleaseNotes = "https://github.com/shazow/ssh-chat/releases/tag/v$version"
    }
}
function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix
}

Update-Package -ChecksumFor None