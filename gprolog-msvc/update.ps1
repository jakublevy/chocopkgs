import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(?i)(^\s*file\s*=\s*)(.*)"  = "`${1}Join-Path `$toolsDir '$($Latest.FileName32)'"
            "(?i)(^\s*file64\s*=\s*)(.*)"  = "`${1}Join-Path `$toolsDir '$($Latest.FileName64)'"
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+x86:).*"          = "`${1} $($Latest.Url32)"
            "(?i)(\s+x64:).*"          = "`${1} $($Latest.Url64)"
            "(?i)(\s+checksum32:).*"   = "`${1} $($Latest.Checksum32)"
            "(?i)(\s+checksum64:).*"   = "`${1} $($Latest.Checksum64)"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'http://www.gprolog.org'
    $files = $download_page.links | ? href -match 'setup-gprolog-\d+\.\d+(\.\d+)*-msvc-x64\.exe' | select -exp href
    $versions = $files | % { [regex]::Match($_, 'setup-gprolog-(\d+\.\d+(\.\d+)*)-msvc-x64\.exe').Groups[1].Value }
    $version = $versions | sort -Descending {[version] $_ } | select -First 1 
    @{
        Version = $version
        Url32   = "http://www.gprolog.org/setup-gprolog-$version-msvc-x86.exe"
        Url64   = "http://www.gprolog.org/setup-gprolog-$version-msvc-x64.exe"
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -NoSuffix -Purge
}

Update-Package -ChecksumFor None
