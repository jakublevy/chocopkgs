$ErrorActionPreference = 'Stop'
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
  validExitCodes= @(0, 1, 2)
  # 0 installed (nothing more, nothing less)
  # 1 installed, but reboot is required now (prior installation no pending reboot)
  # 2 installed, but there was already a pending reboot prior to installation
}

if((Get-OSArchitectureWidth -Compare 32) -or $env:ChocolateyForceX86) {
  Write-Warning 'Wacom has ended support for 32-bit operating systems.'
  Write-Warning '32-bit users should specify version 6.3.40.3'
  Write-Error '32-bit is no longer supported.'
}

Install-ChocolateyPackage @packageArgs
