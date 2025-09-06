import-module chocolatey-au

function global:au_SearchReplace {
    @{  
        ".\tools\chocolateyinstall.ps1"   = @{
            "(?i)(^\s*fileFullPath\s*=\s*)(.*)"  = "`${1}Join-Path `$toolsDir '$($Latest.FileName32)'"
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+checksum32:).*"     = "`${1} $($Latest.Checksum32)"
            "(?i)(\s+Go to).*"           = "`${1} $($Latest.Url32)"
        }
        ".\steghide.nuspec" = @{
            "(?i)(\<projectSourceUrl\>).*(\<\/projectSourceUrl\>)" = "`${1}$($Latest.ProjectSrcUrl)`${2}"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://sourceforge.net/projects/steghide/files/steghide'
    $relative_urls  = $download_page.links | ? href -match ".*/\d+\.\d+(\.\d+)*/$" | Select-Object -exp href
    $versions = $relative_urls | % { ([regex]::Match($_, '.*/(\d+\.\d+(\.\d+)*)/$')).Groups[1].Value }
    $version = $versions | Sort-Object -Descending {[version] $_ } | Select-Object -First 1
    @{
        Url32        = "https://sourceforge.net/projects/steghide/files/steghide/$version/steghide-$version-win32.zip"
        Version      = $version
        ProjectSrcUrl= "https://sourceforge.net/projects/steghide/files/steghide/$version/steghide-$version.tar.gz"
    }
}

Update-Package -ChecksumFor None
