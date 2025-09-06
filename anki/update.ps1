import-module chocolatey-au
. $([System.IO.Path]::Combine((Split-Path -Parent $PSScriptRoot), '.scripts', 'Get-GithubLatestReleaseLinks.ps1'))

$dir = Split-Path -parent $MyInvocation.MyCommand.Definition

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(^[$]version\s*=\s*)('.*')"  = "`$1'$($Latest.Version)'"
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
        ".\anki.nuspec" = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $rel = (Get-GitHubLatestReleaseLinks -user 'ankitects' -repository 'anki').Links | % href

    $relative_url  = $rel | Where-Object { $_ -match '/ankitects/anki/releases/download/\d+\.\d+(\.\d+)*/anki-\d+\.\d+(\.\d+)*-windows-qt6\.exe' } | Select-Object -First 1
    $version = ([regex]::Match($relative_url, 'download/(\d+\.\d+(\.\d+)*)/anki-\d+\.\d+(\.\d+)*-windows-qt6\.exe')).Groups[1].Value
    @{
        Url64        = "https://github.com/ankitects/anki/releases/download/$version/anki-$version-windows-qt6.exe"
        Version      = $version
        ReleaseNotes = "https://github.com/ankitects/anki/releases/tag/$version"
    }
}

function global:au_BeforeUpdate {
    $toolsDir = Join-Path $dir "tools"
    $global:Latest.FileName64 = "anki-$($Latest.Version)-windows-qt6.exe"
    Invoke-WebRequest -UseBasicParsing -Uri $Latest.Url64 -OutFile (Join-Path $toolsDir $Latest.FileName64)
    $global:Latest.Checksum64 = (Get-FileHash (Join-Path $toolsDir $Latest.FileName64) -Algorithm SHA256).Hash
    Get-ChildItem -Path $toolsDir -Filter '*.exe' | Remove-Item -Force
}

Update-Package -ChecksumFor none