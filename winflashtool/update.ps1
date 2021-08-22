import-module au

function global:au_SearchReplace {
    @{
        ".\winflashtool.nuspec" = @{
            "(?i)(\<dependency id=""winflashtool.portable"" version=""\[).*(""\] /\>)" = "`${1}$($Latest.Version)`${2}"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri 'https://sysprogs.com/winflashtool/download/'
    $relative_url  = $download_page.Links | Where-Object href -match 'WinFLASHTool-' | Select-Object -First 1 -expand href
    $version     = ([regex]::Match($relative_url, '/WinFLASHTool-(\d+\.\d+(\.\d+)*)\.exe')).Groups[1].Value
    @{
        Version      = $version
    }
}

Update-Package -ChecksumFor None
