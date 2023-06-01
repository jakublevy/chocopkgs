import-module au
. $([System.IO.Path]::Combine((Split-Path -Parent $PSScriptRoot), '.scripts', 'Get-GithubLatestReleaseLinks.ps1'))

$dir = Split-Path -parent $MyInvocation.MyCommand.Definition

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1" = @{
            "(^[$]checksum_kcc\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumKcc)'"
            "(^[$]checksum_c2e\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumC2e)'"
            "(^[$]checksum_c2p\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumC2p)'"
        }
        ".\kindle-comic-converter.nuspec"   = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $rel = (Get-GitHubLatestReleaseLinks -user 'ciromattia' -repository 'kcc').Links | % href
    $relative_url  = $rel | Where-Object { $_ -match '/ciromattia/kcc/releases/download/v\d+\.\d+(\.\d+)*/kcc_\d+\.\d+(\.\d+)*\.exe' | Select-Object -First 1 }
    $version = ([regex]::Match($relative_url, 'v(\d+\.\d+(\.\d+)*)')).Groups[1].Value
    @{
        Version      = $version
        ReleaseNotes = "https://github.com/ciromattia/kcc/blob/v$version/CHANGELOG.md"
    }
}

function global:au_BeforeUpdate {
    $toolsDir = Join-Path $dir "tools"
    Get-ChildItem -Path $toolsDir -Filter '*.exe' | Remove-Item -Force

    Invoke-WebRequest -UseBasicParsing -Uri 'https://github.com/ciromattia/kcc/releases/download/v5.6.2/kcc_5.6.2.exe' -OutFile (Join-Path $toolsDir 'kcc.exe')
    $global:Latest.ChecksumKcc = (Get-FileHash (Join-Path $toolsDir 'kcc.exe') -Algorithm SHA256).Hash

    Invoke-WebRequest -UseBasicParsing -Uri 'https://github.com/ciromattia/kcc/releases/download/v5.6.2/kcc-c2e_5.6.2.exe' -OutFile (Join-Path $toolsDir 'kcc-c2e.exe')
    $global:Latest.ChecksumC2e = (Get-FileHash (Join-Path $toolsDir 'kcc-c2e.exe') -Algorithm SHA256).Hash

    Invoke-WebRequest -UseBasicParsing -Uri 'https://github.com/ciromattia/kcc/releases/download/v5.6.2/kcc-c2p_5.6.2.exe' -OutFile (Join-Path $toolsDir 'kcc-c2p.exe')
    $global:Latest.ChecksumC2p = (Get-FileHash (Join-Path $toolsDir 'kcc-c2p.exe') -Algorithm SHA256).Hash

    Get-ChildItem -Path $toolsDir -Filter '*.exe' | Remove-Item -Force
}

Update-Package -ChecksumFor None -NoCheckChocoVersion
