import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(?i)(^\s*file\s*=\s*)(.*)"   = "`${1}Join-Path `$toolsDir '$($Latest.FileName32)'"
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+Go to).*"         = "`${1} $($Latest.Url32)"
            "(?i)(\s+checksum32:).*"   = "`${1} $($Latest.Checksum32)"
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
        Url32            = "https://sourceforge.net/projects/lpsolve/files/lpsolve/$version/lp_solve_$($version)_IDE_Setup.exe"
        ReleaseNotes     = "https://sourceforge.net/projects/lpsolve/files/lpsolve/$version/README.txt"
        ProjectSourceUrl = "https://sourceforge.net/projects/lpsolve/files/lpsolve/$version/lp_solve_$($version)_source.tar.gz"
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -NoSuffix -Purge
}

Update-Package -ChecksumFor None
