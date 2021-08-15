$ErrorActionPreference = 'Stop';
$toolsDir   = $(Split-Path -Parent $MyInvocation.MyCommand.Definition)
$version    = '1.8.8'
$checksum64 = 'AD3C3651562AD7D3F8BD4086E4ED3F695D41F03555AB795A040C7CFB6F11E932'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  url64Bit      = "https://sourceforge.net/projects/deadbeef/files/travis/windows/$version/deadbeef-$version-windows-x86_64.zip"
  checksum64    = $checksum64
  checksumType64= 'sha256'
  unzipLocation = $toolsDir
  validExitCodes= @(0)
}

Install-ChocolateyZipPackage @packageArgs