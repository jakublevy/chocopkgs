$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$version = '12.0.1'
$checksum = '69520172a725eaca36e89a8098372f86e92ebaac27c9b9926bd849bc0f4da265'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  url           = "https://www.proficad.com/down/$($version.Split('.')[0])/proficad_portable_en.zip"
  checksum      = $checksum
  checksumType  = 'sha256'
  unzipLocation = "$toolsDir\bin"
  validExitCodes= @(0)
}

Install-ChocolateyZipPackage @packageArgs
