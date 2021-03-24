$ErrorActionPreference = 'Stop';
$toolsDir   = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$checksum64 = 'E465225BEDC50523397F9094914722897DC56509C7FCB6861AC815A94D638DDE'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'EXE'
  url64bit       = 'https://kcc.iosphe.re/Windows/'
  softwareName   = 'Kindle Comic Converter*'
  checksum64     = $checksum64
  checksumType64 = 'sha256'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
}

$addionalArgs = Get-PackageParameters

if($addionalArgs['InstallationPath']) {
  $path = $addionalArgs['InstallationPath']
  $packageArgs['silentArgs'] += " /DIR=""$path"""
}

$tasks = @('desktopicon', 'cbzassociation', 'cb7association', 'cbrassociation')
if(!$addionalArgs['CreateDesktopIcon']) {
  $tasks[0] = '!' + $tasks[0]
}
if(!$addionalArgs['CBZassociation']) {
  $tasks[1] = '!' + $tasks[1]
}
if(!$addionalArgs['CB7association']) {
  $tasks[2] = '!' + $tasks[2]
}
if(!$addionalArgs['CBRassociation']) {
  $tasks[3] = '!' + $tasks[3]
}
$packageArgs['silentArgs'] += " /TASKS=`"$($tasks -join ' ')`""

Install-ChocolateyPackage @packageArgs
& "$toolsDir\chocolateybeforemodify.ps1"
