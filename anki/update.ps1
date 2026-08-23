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
    $p = Invoke-WebRequest -UseBasicParsing -Uri 'https://apps.ankiweb.net'
    $links = $p.Links.Href | ? { $_ -match '/releases/download/(\d+\.\d+(\.\d+)*)/anki-\d+\.\d+(\.\d+)*-win-x64\.msi' }

    $version = ([regex]::Match($links, '/releases/download/(\d+\.\d+(\.\d+)*)/anki-\d+\.\d+(\.\d+)*-win-x64\.msi')).Groups[1].Value
    @{
        Url64        = "https://github.com/ankitects/anki/releases/download/$version/anki-$version-win-x64.msi"
        Version      = $version
        ReleaseNotes = "https://github.com/ankitects/anki/releases/tag/$version"
    }
}

function global:au_BeforeUpdate {
    $toolsDir = Join-Path $dir "tools"
    $global:Latest.FileName64 = "anki-$($Latest.Version)-win-x64.msi"
    Invoke-WebRequest -UseBasicParsing -Uri $Latest.Url64 -OutFile (Join-Path $toolsDir $Latest.FileName64)
    $global:Latest.Checksum64 = (Get-FileHash (Join-Path $toolsDir $Latest.FileName64) -Algorithm SHA256).Hash
    Get-ChildItem -Path $toolsDir -Filter '*.msi' | Remove-Item -Force
}

Update-Package -ChecksumFor none