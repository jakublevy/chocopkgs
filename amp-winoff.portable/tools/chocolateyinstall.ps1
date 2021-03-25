$ErrorActionPreference = 'Stop';
$toolsDir = $(Split-Path -Parent $MyInvocation.MyCommand.Definition)
$checksum = 'AF0637EBC5122A93C4DA49EFB2E29CAF999EBBE0C4352A7628732F612893F43D'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  url           = 'https://www.ampsoft.net/files/WinOFF.zip'
  checksum      = $checksum
  checksumType  = 'sha256'
  unzipLocation = "$toolsDir\bin"
  silentArgs    = "/S"
  validExitCodes= @(0)
}

Install-ChocolateyZipPackage @packageArgs

$shimArgs = @{
  path       = $packageArgs['unzipLocation']
  itemType   = 'file'
  errorAction= 'SilentlyContinue'
}

New-Item `
  -Name 'WinOFF.exe.gui' `
  @shimArgs

New-Item `
  -Name 'WinOFF_admin.exe.ignore' `
  @shimArgs

New-Item `
  -Name 'WinOFF_guardian.exe.ignore' `
  @shimArgs

New-Item `
  -Name 'WinOFF_launcher.exe.ignore' `
  @shimArgs
