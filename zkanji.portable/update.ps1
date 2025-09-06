import-module chocolatey-au

function global:au_SearchReplace {
    @{  
        ".\tools\chocolateyinstall.ps1"   = @{
            "(?i)(^\s*fileFullPath\s*=\s*)(.*)" = "`${1}Join-Path `$toolsDir '$($Latest.FileName32)'"
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+checksum32:).*"     = "`${1} $($Latest.Checksum32)"
            "(?i)(\s+Go to).*"           = "`${1} $($Latest.Url32)"
        }
        ".\zkanji.portable.nuspec" = @{
            "(?i)(\<projectSourceUrl\>).*(\<\/projectSourceUrl\>)" = "`${1}$($Latest.SourceUrl)`${2}"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://sourceforge.net/projects/zkanji/files/zkanji'
    $relative_urls  = $download_page.links | ? href -match ".*/v\d+\.\d+(\.\d+)*/$" | Select-Object -exp href
    $versions = $relative_urls | % { ([regex]::Match($_, '.*/v(\d+\.\d+(\.\d+)*)/$')).Groups[1].Value }
    $version = $versions | Sort-Object -Descending {[version] $_ } | Select-Object -First 1
    $versionNoDots = $version.Replace('.', '')
    @{
        Version  = $version
        Url32    = "https://sourceforge.net/projects/zkanji/files/zkanji/v$version/zkanjiv$versionNoDots.zip/download"
        SourceUrl= "https://sourceforge.net/projects/zkanji/files/zkanji/v$version/zkanjiv$($versionNoDots)_src.zip"
    }
}

Update-Package -ChecksumFor None
