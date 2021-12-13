import-module au

$dir = Split-Path -parent $MyInvocation.MyCommand.Definition

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyinstall.ps1"   = @{
            "(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $response    = Invoke-WebRequest -UseBasicParsing -Uri 'https://www.joeware.net/freetools/tools/w2klockdesktop/index.htm'
    $response    = $response.Content.Substring($response.Content.IndexOf('Current Version'))
    $version     = ([regex]::Match($response, '(\d+\.\d+(\.\d+)*)')).Groups[1].Value
    @{
        Version  = $version
    }
}

function global:au_BeforeUpdate {
    $toolsDir = Join-Path $dir "tools"
    $global:Latest.FileName32 = "W2KLockDesktop.zip"
    $postParams = @{download = 'W2KLockDesktop.zip'; B1 = 'Download+Now'}
    Invoke-WebRequest -UseBasicParsing -Uri 'https://www.joeware.net/downloads/dl.php' -Method 'POST' -OutFile "$dir\W2KLockDesktop.zip" -Body $postParams
    $global:Latest.Checksum32 = (Get-FileHash (Join-Path $toolsDir $Latest.FileName32) -Algorithm SHA256).Hash
    Get-ChildItem -Path $dir -Filter '*.zip' | Remove-Item -Force
}

Update-Package -ChecksumFor None
