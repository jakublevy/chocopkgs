import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(^[$]version\s*=\s*)('.*')"  = "`$1'$($Latest.VersionClip)'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
        ".\tools\install.iss"   = @{
            "(?i)(Version=).*"         = "`${1}$($Latest.Version)"
        }
        ".\tools\uninstall.iss"   = @{
            "(?i)(Version=).*"         = "`${1}$($Latest.Version)"
        }
        ".\tools\uninstallModeler.iss"   = @{
            "(?i)(Version=).*"         = "`${1}$($Latest.Version)"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://www.clipstudio.net/en/modeler'
    $links = $download_page.links | ? href -match '\.exe' | Select-Object -first 1 -exp href
    $versionOriginal = [regex]::Match($links, '/(\d+)/').Groups[1].Value
    $releaseNotesPage = Invoke-WebRequest -UseBasicParsing -Uri 'https://www.clipstudio.net/modeler/en/release_note'
    $content = $releaseNotesPage.Content.Substring($releaseNotesPage.Content.IndexOf('<body'))
    $possibleVersions = [regex]::Matches($content, '(\d+\.\d+(\.\d+)*)')
    $versionChoco = (Find-Version -OriginalVersion $versionOriginal -FoundVersions $possibleVersions)
    @{
        Url64        = "https://vd.clipstudio.net/clipcontent/paint/app/$versionOriginal/CSP_$($versionOriginal)w_setup.exe"
        Version      = $versionChoco
        VersionClip  = $versionChoco -replace '.', ''
    }
}

function Find-Version {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $OriginalVersion,

        [Parameter(Mandatory)]
        [System.Text.RegularExpressions.MatchCollection] $FoundVersions
    )   
    foreach($match in $FoundVersions) {
        if($match.Success) {
            $version = $match.Groups[1].Value.ToString()
            if($OriginalVersion -eq $version.Replace('.', '')) {
                return $version
            }
        }
    }
    throw "No matching version found."
}

function global:au_AfterUpdate($pkg) {
    Set-DescriptionFromReadme $pkg
}

Update-Package
