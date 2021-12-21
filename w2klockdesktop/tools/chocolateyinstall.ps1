$ErrorActionPreference = 'Stop'
$toolsDir              = Split-Path -parent $MyInvocation.MyCommand.Definition
$checksum32            = '036A6262131A782DEF8424F585912DAA4F6F0070D06D9A7057ED7E1DACE9C06B'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  file          = "$toolsDir\W2KLockDesktop.zip"
  checksum      = $checksum32
  checksumType  = 'sha256'
  unzipLocation = "$toolsDir\bin"
  validExitCodes= @(0)
}

$requestParams = @{
  useBasicParsing = $true
  uri             = 'https://www.joeware.net/downloads/dl2.php'
  method          = 'POST'
  outFile         = "$toolsDir\W2KLockDesktop.zip"
  body            = @{
    download = 'W2KLockDesktop.zip'
    B1       = 'Download+Now'
  }
}

Invoke-WebRequest @requestParams

Install-ChocolateyZipPackage @packageArgs

Remove-Item `
  -Path "$toolsDir\W2KLockDesktop.zip" `
  -ErrorAction SilentlyContinue `
  -Force