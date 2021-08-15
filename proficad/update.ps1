import-module au

function global:au_SearchReplace {
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
