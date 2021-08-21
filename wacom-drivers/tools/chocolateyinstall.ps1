$ErrorActionPreference = 'Stop';
$version  = '6.3.44-1'
$checksum64 = 'D687B2CCE4F338D83C9642C4B2B32967993DCC5D9004D055CC75EC5723B37F09'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url64         = "https://cdn.wacom.com/u/productsupport/drivers/win/professional/WacomTablet_$version.exe"
  softwareName  = 'Wacom Tablet*'
  checksum64    = $checksum64
  checksumType64= 'sha256'
  silentArgs    = '/S'
  validExitCodes= @(0, 2)
}

Install-ChocolateyPackage @packageArgs
