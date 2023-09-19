$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$version = '12.2.7'
$checksum = 'dc94b5b739913586aedc4131dd284f0bf4e8c7607ef07785e2a306e7aa7254cf'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  url           = "https://www.proficad.com/down/$($version.Split('.')[0])/proficad_portable_en.zip"
  checksum      = $checksum
  checksumType  = 'sha256'
  unzipLocation = "$toolsDir\bin"
  validExitCodes= @(0)
}

Install-ChocolateyZipPackage @packageArgs
