$ErrorActionPreference = 'Stop'
$toolsDir              = Split-Path -parent $MyInvocation.MyCommand.Definition
$ahkFile               = "$toolsDir\install.ahk"

. "$toolsDir\utils.ps1"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = 'https://download01.logi.com/web/ftp/pub/techsupport/joystick/lgs510j.exe'
  url64         = 'https://download01.logi.com/web/ftp/pub/techsupport/joystick/lgs510j_x64.exe'
  softwareName  = 'Logicool Gaming Software 5.10'
  checksum      = '22B54C66B65E61111E0F86EFEF27737BDCCF40130118E6DB62DC5274D1BAF6F2'
  checksumType  = 'sha256'
  checksum64    = '2A6A7A2E0BDCBC0F300F50268DF33B2A44E73E837AC6E29875036BDCEDFD5D42'
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