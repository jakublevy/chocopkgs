$ErrorActionPreference = 'Stop'
$toolsDir              = Split-Path -parent $MyInvocation.MyCommand.Definition
$ahkFile               = "$toolsDir\install.ahk"

. "$toolsDir\utils.ps1"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = "https://download01.logi.com/web/ftp/pub/techsupport/joystick/lgs510.exe"
  url64         = "https://download01.logi.com/web/ftp/pub/techsupport/joystick/lgs510_x64.exe"
  softwareName  = 'Logitech Gaming Software 5.10'
  checksum      = 'e59842d1c4bf1dc9bc9e228fa7d565efec63c2ca525367198cdb59dd091da7e5'
  checksumType  = 'sha256'
  checksum64    = 'e07a278eab65df9fa50b3c454627c7169beb41824015839d2a0368caf284ca76'
  checksumType64= 'sha256'
  validExitCodes= @(0)
}

$additionalArgs = Get-PackageParameters
if($additionalArgs['Language']) {
  Set-AhkVariableValue `
    -FileName $ahkFile `
    -Variable 'selectedLanguage' `
    -NewValue $additionalArgs['Language'] `
    -Escape
}

$ahkProcess = Start-Process `
                -FilePath 'AutoHotKey' `
                -ArgumentList "`"$ahkFile`"" `
                -PassThru

Install-ChocolateyPackage @packageArgs

& "$toolsDir\chocolateybeforemodify.ps1"

Stop-Process $ahkProcess -Force