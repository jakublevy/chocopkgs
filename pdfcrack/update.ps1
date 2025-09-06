import-module chocolatey-au
. $([System.IO.Path]::Combine((Split-Path -Parent $PSScriptRoot), '.scripts', 'Get-GithubLatestReleaseLinks.ps1'))


function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(?i)(^\s*fileFullPath64\s*=\s*)(.*)" = "`${1}Join-Path `$toolsDir '$($Latest.FileName64)'"
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+Go to).*"         = "`${1} $($Latest.Url64)"
            "(?i)(\s+checksum64:).*"   = "`${1} $($Latest.Checksum64)"
        }
    }
}

function global:au_GetLatest {
    $rel = (Get-GitHubLatestReleaseLinks -user 'alitrack' -repository 'PDFCrack').Links | % href
    $relative_url  = $rel | Where-Object { $_ -match '/alitrack/PDFCrack/releases/download/\d+\.\d+(\.\d+)*/pdfcrack-v\d+\.\d+(\.\d+)*-windows-amd64\.zip' } | Select-Object -First 1
    $version = ([regex]::Match($relative_url, 'pdfcrack-v(\d+\.\d+(\.\d+)*)-windows-amd64\.zip')).Groups[1].Value
    @{
        Url64        = "https://github.com/alitrack/PDFCrack/releases/download/$version/pdfcrack-v$version-windows-amd64.zip"
        Version      = $version
    }
}
function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix
}



Update-Package -ChecksumFor None