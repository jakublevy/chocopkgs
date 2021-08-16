import-module au

function global:au_SearchReplace {
    @{  ".\amp-winoff.nuspec" = @{
            "(?i)(\<dependency id=""amp-winoff.install"" version=""\[).*(""\] /\>)" = "`${1}$($Latest.Version)`${2}"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'http://www.ampsoft.net/utilities/WinOFF.php'
    $version = [regex]::Match($download_page.Content, '<h1>AMP WinOFF (\d+\.\d+(\.\d+)*)</h1>').Groups[1]
    @{
        Version  = $version
    }
}

update
