import-module au
. $([System.IO.Path]::Combine((Split-Path -Parent $PSScriptRoot), '.scripts', 'Get-GithubLatestReleaseLinks.ps1'))


function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(?i)(^\s*fileFullPath64\s*=\s*)(.*)" = "`${1}Join-Path `$toolsDir '$($Latest.FileName64)'"
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+Go to).*"         = "`${1} $($Latest.Url64)"
            "(?i)(\s+checksum64:).*"   = "`${1} $($Latest.Checksum64)"
        }
        ".\manga-py.nuspec" = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $rel = (Get-GitHubLatestReleaseLinks -user 'manga-py' -repository 'manga-py').Links | % href
    $relative_url  = $rel | Where-Object { $_ -match '/manga-py/manga-py/archive/refs/tags/\d+\.\d+(\.\d+)\.zip' } | Select-Object -First 1
    $version = ([regex]::Match($relative_url, '(\d+\.\d+(\.\d+)*)\.zip')).Groups[1].Value
    # $req = Invoke-WebRequest -UseBasicParsing -Uri 'https://api.github.com/repos/manga-py/manga-py/releases'
    # $json = ConvertFrom-Json $req.Content
    # if($json[0].prerelease) { $version = $json[1].tag_name }
    @{
        Version      = $version
        Url64        = "https://github.com/manga-py/manga-py-win/releases/download/$version/manga_py-$version-win-x64.zip"
        ReleaseNotes = "https://github.com/manga-py/manga-py/releases/tag/$version"
    }
}
function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix
}

Update-Package -ChecksumFor None