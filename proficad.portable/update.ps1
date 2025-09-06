import-module chocolatey-au

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^[$]version\s*=\s*)('.*')" = "`$1'$($Latest.Version)'"
        }
    }
}

function global:au_GetLatest {
    $response    = Invoke-WebRequest -UseBasicParsing -Uri 'https://www.proficad.com/download.aspx'
    $response    = $response.Content.Substring($response.Content.IndexOf('class="hint'))
    $version     = ([regex]::Match($response, '(\d+\.\d+(\.\d+)*)')).Groups[1].Value
    @{
        Url32    = "https://www.proficad.com/down/$($version.Split('.')[0])/proficad_portable_en.zip"
        Version  = $version
    }
}



Update-Package -ChecksumFor 32
