$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$version = '11.4.1'
$checksum = '92ec0e78d395cf34348c64618bb5b029514aa777e003dc04bb9da60308136cb0'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  url           = "https://www.proficad.com/down/$($version.Split('.')[0])/proficad_portable_en.zip"
  checksum      = $checksum
  checksumType  = 'sha256'
  unzipLocation = "$toolsDir\bin"
  validExitCodes= @(0)
}

Install-ChocolateyZipPackage @packageArgs
