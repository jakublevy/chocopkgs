import-module au

function global:au_SearchReplace {
    @{  ".\proficad.nuspec" = @{
            "(?i)(\<dependency id=""proficad.install"" version="").*("" /\>)" = "`${1}$($Latest.Version)`${2}"
        }
    }
}


function global:au_GetLatest {
    $response    = Invoke-WebRequest -UseBasicParsing -Uri 'https://www.proficad.com/download.aspx'
    $response    = $response.Content.Substring($response.Content.IndexOf('id="info'))
    $version     = ([regex]::Match($response, '(\d+\.\d+(\.\d+)*)')).Groups[1].Value
    @{
        Version  = $version
    }
}

update
