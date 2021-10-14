import-module au

function global:au_SearchReplace {
    @{  
        ".\zkanji.nuspec" = @{
            "(?i)(\<dependency id=""zkanji.install"" version=""\[).*(""\] /\>)" = "`${1}$($Latest.Version)`${2}"
            "(?i)(\<projectSourceUrl\>).*(\<\/projectSourceUrl\>)" = "`${1}$($Latest.SourceUrl)`${2}"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://sourceforge.net/projects/zkanji/files/zkanji'
    $relative_urls  = $download_page.links | ? href -match ".*/v\d+\.\d+(\.\d+)*/$" | Select-Object -exp href
    $versions = $relative_urls | % { ([regex]::Match($_, '.*/v(\d+\.\d+(\.\d+)*)/$')).Groups[1].Value }
    $version = $versions | Sort-Object -Descending {[version] $_ } | Select-Object -First 1
    $versionNoDots = $versions.Replace(".", "")
    @{
        Version  = $version
        SourceUrl= "https://sourceforge.net/projects/zkanji/files/zkanji/v$version/zkanjiv$($versionNoDots)_src.zip"
    }
}

function global:au_AfterUpdate($pkg) {
    Set-DescriptionFromReadme $pkg
}

Update-Package -ChecksumFor None
