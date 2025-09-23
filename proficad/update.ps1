import-module chocolatey-au

function global:au_SearchReplace {
    @{  
        ".\proficad.nuspec" = @{
            "(?i)(<dependency id=""proficad.install"" version=""\[).*(\]"" />)" = "`${1}$($Latest.Version)`${2}"
        }
    }
}


function global:au_GetLatest {
    $response    = Invoke-WebRequest -UseBasicParsing -Uri 'https://www.proficad.com/download.aspx'
    $links = $response.Links | ? { $_ -match 'setup_full.exe' }
    $versions = [regex]::Matches($links.OuterHTML, '(?is)version[ \r\n]*(\d+\.\d+(\.\d+)*)').Groups[1].Value

    $version = $versions | % { [version]$_ } | Sort-Object -Descending | Select-Object -First 1
    $version = $version.ToString()
    @{
        Version  = $version
    }
}

Update-Package -ChecksumFor None
