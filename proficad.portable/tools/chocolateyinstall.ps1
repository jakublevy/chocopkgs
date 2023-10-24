$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$version = '12.3.1'
$checksum = '3c16058c3e4458e1ca5a5e4aeea5324ce14638a823e0aa7758bfe8169ebb9f37'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  url           = "https://www.proficad.com/down/$($version.Split('.')[0])/proficad_portable_en.zip"
  checksum      = $checksum
  checksumType  = 'sha256'
  unzipLocation = "$toolsDir\bin"
  validExitCodes= @(0)
}

Install-ChocolateyZipPackage @packageArgs
