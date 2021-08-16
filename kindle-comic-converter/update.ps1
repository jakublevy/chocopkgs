import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1" = @{
            "(?i)(^\s*file64\s*=\s*)(.*)" = "`${1}Join-Path `$toolsDir '$($Latest.FileName64)'"
        }
        ".\kindle-comic-converter.nuspec"   = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+checksum64:).*" = "`${1} $($Latest.Checksum64)"
        }
    }
}

function global:au_GetLatest {
    $response    = Invoke-WebRequest -UseBasicParsing -Uri 'https://kcc.iosphe.re/Windows/' -Method Head
    $file_name   = ([regex]::Match($response.Headers.'Content-Disposition', 'filename=(.*\.exe)')).Groups[1].Value
    $version     = ([regex]::Match($file_name, '(\d+\.\d+(\.\d+)*)\.exe')).Groups[1].Value
    @{
        Url64        = 'https://kcc.iosphe.re/Windows/'
        Version      = $version
        ReleaseNotes = "https://github.com/ciromattia/kcc/blob/$version/CHANGELOG.md"
    }
}

function global:au_BeforeUpdate {
    Get-ChildItem -Path ".\tools" -Filter '*.exe' | Remove-Item -Force
    $global:Latest.FileName64 = "KindleComicConverter_win_$($Latest.Version).exe"
    Invoke-WebRequest -UseBasicParsing -Uri 'https://kcc.iosphe.re/Windows/' -OutFile (Join-Path "tools" $Latest.FileName64)
    $global:Latest.Checksum64 = (Get-FileHash (Join-Path "tools" $Latest.FileName64) -Algorithm SHA256).Hash
}

Update-Package -ChecksumFor None
