import-module au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(^[$]version\s*=\s*)('.*')"  = "`$1'$($Latest.VersionClip)'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
        ".\tools\install.iss"   = @{
            "(?i)(Version=)[^v].*"         = "`${1}$($Latest.Version)"
        }
    }
}

function global:au_GetLatest {
    # $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://www.clipstudio.net/en/purchase/trial'
    # $links = $download_page.links | ? href -match '\.exe' | Select-Object -first 1 -exp href
    # $versionOriginal = [regex]::Match($links, '/(\d+)/').Groups[1].Value
    $releaseNotesPage = Invoke-WebRequest -UseBasicParsing -Uri 'https://www.clipstudio.net/en/dl/release_note'
    $content = $releaseNotesPage.Content.Substring($releaseNotesPage.Content.IndexOf('<body'))
    $possibleVersions = [regex]::Matches($content, '(\d+\.\d+(\.\d+)*)') | ? { $_.Success } | % { $_.Groups[1].Value } | Select-Object -Unique | Sort-Object -Descending {[version] $_ }
    foreach($pv in $possibleVersions) {
        try{
            $versionNoDot = $pv.Replace('.', '')
            Invoke-WebRequest -UseBasicParsing -Uri "https://vd.clipstudio.net/clipcontent/paint/app/$versionNoDot/CSP_${versionNoDot}w_setup.exe" -Method Head
            $versionChoco = $pv
            break
        }
        catch {

        }
    }
    @{
        Version      = $versionChoco
        VersionClip  = $versionNoDot
        Url64        = "https://vd.clipstudio.net/clipcontent/paint/app/$versionNoDot/CSP_$($versionNoDot)w_setup.exe"
    }
}

function Find-Version {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $OriginalVersion,

        [Parameter(Mandatory)]
        [array] $FoundVersions
    )   
    foreach($foundVersion in $FoundVersions) {
        $version = $foundVersion.Replace('.', '')
        if($version -eq $OriginalVersion) {
            return $foundVersion
        }
    }
    throw "No matching version found."
}

Update-Package -ChecksumFor 64
