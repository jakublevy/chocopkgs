import-module chocolatey-au

function global:au_SearchReplace {
    @{  
        ".\tools\chocolateyinstall.ps1"   = @{
            "(?i)(^\s*file\s*=\s*)(.*)"  = "`${1}Join-Path `$toolsDir '$($Latest.FileName32)'"
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+checksum32:).*"     = "`${1} $($Latest.Checksum32)"
            "(?i)(\s+Go to).*"           = "`${1} $($Latest.Url32)"
        }
        ".\zkanji.install.nuspec" = @{
            "(?i)(\<projectSourceUrl\>).*(\<\/projectSourceUrl\>)" = "`${1}$($Latest.SourceUrl)`${2}"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://sourceforge.net/projects/zkanji/files/zkanji'
    $relative_urls  = $download_page.links | ? href -match ".*/v\d+\.\d+(\.\d+)*/$" | Select-Object -exp href
    $versions = $relative_urls | % { ([regex]::Match($_, '.*/v(\d+\.\d+(\.\d+)*)/$')).Groups[1].Value }
    $version = $versions | Sort-Object -Descending {[version] $_ } | Select-Object -First 1
    $versionUnderscore = $version.Replace('.', '_')
    $versionNoDots = $versions.Replace(".", "")
    @{
        Version  = $version
        SourceUrl= "https://sourceforge.net/projects/zkanji/files/zkanji/v$version/zkanjiv$($versionNoDots)_src.zip"
        Url32    = "https://sourceforge.net/projects/zkanji/files/zkanji/v$version/zkanji_$($versionUnderscore)_Setup_newdir.exe"
    }
}

Update-Package -ChecksumFor None
