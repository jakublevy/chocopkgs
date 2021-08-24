$ErrorActionPreference = 'Stop'
$toolsDir = $(Split-Path -Parent $MyInvocation.MyCommand.Definition)
$checksum = 'AF0637EBC5122A93C4DA49EFB2E29CAF999EBBE0C4352A7628732F612893F43D'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  url           = 'https://www.ampsoft.net/files/WinOFF.zip'
  checksum      = $checksum
  checksumType  = 'sha256'
  unzipLocation = "$toolsDir\bin"
  validExitCodes= @(0)
}

Install-ChocolateyZipPackage @packageArgs

$shimArgs = @{
  path       = $packageArgs['unzipLocation']
  itemType   = 'file'
  errorAction= 'SilentlyContinue'
}

$createItemList = @('WinOFF.exe.gui', 'WinOFF_admin.exe.ignore', 'WinOFF_guardian.exe.ignore', 'WinOFF_launcher.exe.ignore')
$createItemList | % { New-Item -Name $_ @shimArgs }
