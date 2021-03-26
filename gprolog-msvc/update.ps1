import-module au

function global:au_SearchReplace {
    $url64 = "http://www.gprolog.org/setup-gprolog-$($Latest.Version)-msvc-x64.exe"
    $url64 = "http://www.gprolog.org/setup-gprolog-$($Latest.Version)-msvc-x86.exe"
    Invoke-WebRequest -Uri $url64 -OutFile '_gprolog-x64.exe'
    Invoke-WebRequest -Uri $url -OutFile '_gprolog-x86.exe'
    $checksum64 = (Get-FileHash '_gprolog-x64.exe' -Algorithm SHA256).Hash
    $checksum = (Get-FileHash '_gprolog-x86.exe' -Algorithm SHA256).Hash
    Remove-Item '_gprolog-x64.exe' -Force
    Remove-Item '_gprolog-x86.exe' -Force

    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(^[$]version\s*=\s*)('.*')"  = "`$1'$($Latest.Version)'"
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$checksum'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$checksum64'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'http://www.gprolog.org'
    $files = $download_page.links | ? href -match 'setup-gprolog-\d+\.\d+(\.\d+)*-msvc-x64.exe' | select -exp href
    $versions = $files | % { [regex]::Match($_, 'setup-gprolog-(\d+\.\d+(\.\d+)*)-msvc-x64.exe').Groups[1].Value }
    $version = $versions | sort -Descending {[version] $_ } | select -First 1 
    @{
        Version = $version
    }
}

update
