$ErrorActionPreference = 'Stop'
$toolsDir              = Split-Path -parent $MyInvocation.MyCommand.Definition
$checksum32            = 'D8CEF6B4511A08014CC9088B37EF2D71BA2B3D2AEEEAF7D698CF566E42930D4E'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  file          = "$toolsDir\GetUserInfo.zip"
  checksum      = $checksum32
  checksumType  = 'sha256'
  unzipLocation = "$toolsDir\bin"
  validExitCodes= @(0)
}

$requestParams = @{
  useBasicParsing = $true
  uri             = 'https://www.joeware.net/downloads/dl.php'
  method          = 'POST'
  outFile         = "$toolsDir\GetUserInfo.zip"
  timeoutSec      = 180
  body            = @{
    download = 'GetUserInfo.zip'
    B1       = 'Download+Now'
  }
}

Write-Host "Please be patient when installing this package, it can take up to 3 minutes due to a slow response of the download server." -ForegroundColor Cyan

Invoke-WebRequest @requestParams

Install-ChocolateyZipPackage @packageArgs

Remove-Item `
  -Path "$toolsDir\GetUserInfo.zip" `
  -ErrorAction SilentlyContinue `
  -Force