import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(?i)(^\s*fileFullPath\s*=\s*)(.*)"   = "`${1}Join-Path `$toolsDir '$($Latest.FileName32)'"
            "(?i)(^\s*fileFullPath64\s*=\s*)(.*)" = "`${1}Join-Path `$toolsDir '$($Latest.FileName64)'"
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+x86:).*"          = "`${1} $($Latest.Url32)"
            "(?i)(\s+x64:).*"          = "`${1} $($Latest.Url64)"
            "(?i)(\s+chm_file:).*"     = "`${1} $($Latest.UrlChm)"
            "(?i)(\s+checksum32:).*"   = "`${1} $($Latest.Checksum32)"
            "(?i)(\s+checksum64:).*"   = "`${1} $($Latest.Checksum64)"
            "(?i)(\s+checksum_chm:).*" = "`${1} $($Latest.ChecksumChm)"
        }
        ".\lpsolve.nuspec" = @{
            "(?i)(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
            "(?i)(\<projectSourceUrl\>).*(\<\/projectSourceUrl\>)" = "`${1}$($Latest.ProjectSourceUrl)`${2}"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://sourceforge.net/projects/lpsolve/files/lpsolve/'
    $relative_urls  = $download_page.links | ? href -match '/\d+\.\d+(\.\d+)*/' | select -exp href
    $versions = $relative_urls | % { ([regex]::Match($_, '/(\d+\.\d+(\.\d+)*)/')).Groups[1].Value }
    $version = $versions | sort -Descending {[version] $_ } | select -First 1
    @{
        Version          = $version
        Url32            = "https://sourceforge.net/projects/lpsolve/files/lpsolve/$version/lp_solve_$($version)_exe_win32.zip"
        Url64            = "https://sourceforge.net/projects/lpsolve/files/lpsolve/$version/lp_solve_$($version)_exe_win64.zip"
        UrlChm           = "https://sourceforge.net/projects/lpsolve/files/lpsolve/$version/lp_solve_$version.chm"
        ReleaseNotes     = "https://sourceforge.net/projects/lpsolve/files/lpsolve/$version/README.txt"
        ProjectSourceUrl = "https://sourceforge.net/projects/lpsolve/files/lpsolve/$version/lp_solve_$($version)_source.tar.gz"
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -NoSuffix -Purge

    Remove-Item -Path '.\*.chm' -Force
    $chmFileName = "lp_solve_$($Latest.Version).chm"
    Invoke-WebRequest -UseBasicParsing -Uri "https://sourceforge.net/projects/lpsolve/files/lpsolve/$($Latest.Version)/$chmFileName" -OutFile $chmFileName -UserAgent [Microsoft.PowerShell.Commands.PSUserAgent]::FireFox
    $global:Latest.ChecksumChm = (Get-FileHash -Path $chmFileName -Algorithm SHA256).Hash
}

Update-Package -ChecksumFor None
