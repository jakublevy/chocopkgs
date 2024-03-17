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
    $releaseNotesPage = Invoke-WebRequest -UseBasicParsing -Uri 'https://www.clipstudio.net/en/dl/release_note/latest/'
    $content = $releaseNotesPage.Content.Substring($releaseNotesPage.Content.IndexOf('<h1'))
    $versionsChoco = [regex]::Matches($content, '(\d+\.\d+(\.\d+)*)') | ? { $_.Success } | % { $_.Groups[1].Value } | Sort-Object -Descending [version] | Get-Unique
    foreach($v in $versionsChoco) {
        $versionNoDot =  $v.Replace('.', '')
        $url = "https://vd.clipstudio.net/clipcontent/paint/app/$versionNoDot/CSP_$($versionNoDot)w_setup.exe"
        try {
            Invoke-WebRequest -UseBasicParsing -Uri $url -Method Head
            return @{
                Version      = $v
                VersionClip  = $versionNoDot
                Url64        = $url
            }
        }
        catch { }
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
