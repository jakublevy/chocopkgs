import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(^[$]version\s*=\s*)('.*')"  = "`$1'$($Latest.Version)'"
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://www.netlimiter.com/docs/infobar'
    $links = $download_page.links | ? href -match '/download/' | Select-Object -exp href 
    $versions = $links | % { ([regex]::Match($_, '.*NLInfoBar-(\d+\.\d+(\.\d+)*)\.exe$')).Groups[1].Value }
    $version = $versions | Sort-Object -Descending {[version] $_ } | Select-Object -First 1
    @{
        Url32        = "https://www.netlimiter.com/files/download/nl4/NLInfoBar-$version.exe"
        Version      = $version
    }
}

function global:au_AfterUpdate($pkg) {
    Set-DescriptionFromReadme $pkg
}

Update-Package
