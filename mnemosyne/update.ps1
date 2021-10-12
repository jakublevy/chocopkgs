import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(?i)(^\s*file\s*=\s*)(.*)"   = "`${1}Join-Path `$toolsDir '$($Latest.FileName32)'"
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+Go to).*"          = "`${1} $($Latest.Url32)"
            "(?i)(\s+checksum32:).*"    = "`${1} $($Latest.Checksum32)"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://sourceforge.net/projects/mnemosyne-proj/files/mnemosyne/'
    $relative_urls  = $download_page.links | ? href -match '/mnemosyne-\d+\.\d+(\.\d+)*/$' | Select-Object -exp href
    $versions = $relative_urls | % { ([regex]::Match($_, '(?i)/mnemosyne-(\d+\.\d+(\.\d+)*)/')).Groups[1].Value }
    $version = $versions | Sort-Object -Descending {[version] $_ } | Select-Object -First 1
    @{
        Version          = $version
        Url32            = "https://sourceforge.net/projects/mnemosyne-proj/files/mnemosyne/mnemosyne-$version/mnemosyne-$version-setup.exe"
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -NoSuffix -Purge
}

function global:au_AfterUpdate($pkg) {
    Set-DescriptionFromReadme $pkg
}

Update-Package -ChecksumFor None
