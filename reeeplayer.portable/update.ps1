import-module au

function global:au_SearchReplace {
    Invoke-WebRequest -UseBasicParsing "https://github.com/FilippVolodin/ReeePlayer/releases/download/v$($Latest.Version)/ReeePlayer-$($Latest.Version)-win-x64.zip" -OutFile '_reeeplayer.zip'
    $checksum64 = (Get-FileHash '_reeeplayer.zip' -Algorithm SHA256).Hash
    Remove-Item '_reeeplayer.zip' -Force
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(^[$]version\s*=\s*)('.*')"  = "`$1'$($Latest.Version)'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$checksum64'"
        }
        ".\reeeplayer.portable.nuspec"   = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://github.com/FilippVolodin/ReeePlayer/releases'
    $relative_url  = $download_page.links | Where-Object href -match '/FilippVolodin/ReeePlayer/releases/download/v\d+\.\d+(\.\d+)*/ReeePlayer-\d+\.\d+(\.\d+)*-win-x64.zip' | Select-Object -First 1 -expand href
    $version = ([regex]::Match($relative_url, 'ReeePlayer-(\d+\.\d+(\.\d+)*)-win-x64\.zip')).Groups[1].Value
    @{
        Version      = $version
        ReleaseNotes = "https://github.com/FilippVolodin/ReeePlayer/releases/tag/v$version"
    }
}

update