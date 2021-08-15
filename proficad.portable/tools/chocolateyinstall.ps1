$ErrorActionPreference = 'Stop';
$toolsDir = $(Split-Path -Parent $MyInvocation.MyCommand.Definition)
$version = '11.2.2'
$checksum = '34EF8E07109951F8FCFF4409DD2A8652D8B9C8CE9D6811FC71FB3A834F669C3D'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  url           = "https://www.proficad.com/down/$($version.Split('.')[0])/proficad_portable_en.zip"
  checksum      = $checksum
  checksumType  = 'sha256'
  unzipLocation = "$toolsDir\bin"
  validExitCodes= @(0)
}

Install-ChocolateyZipPackage @packageArgs