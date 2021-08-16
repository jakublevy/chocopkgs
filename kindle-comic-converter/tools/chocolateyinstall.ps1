$ErrorActionPreference = 'Stop';
$toolsDir   = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'EXE'
  file64         = Join-Path $toolsDir 'KindleComicConverter_win_5.5.2.exe'
  softwareName   = 'Kindle Comic Converter*'
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
Remove-Item -Path $packageArgs['file64'] -Force

& "$toolsDir\chocolateybeforemodify.ps1"
