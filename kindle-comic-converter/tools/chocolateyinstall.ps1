$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'EXE'
  file64         = Join-Path $toolsDir 'KindleComicConverter_win_5.5.2.exe'
  softwareName   = 'Kindle Comic Converter*'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
}

$additionalArgs = Get-PackageParameters

if($additionalArgs['InstallationPath']) {
  $path = $additionalArgs['InstallationPath']
  $packageArgs['silentArgs'] += " /DIR=""$path"""
}

$tasks = @('desktopicon', 'cbzassociation', 'cb7association', 'cbrassociation')
if(!$additionalArgs['CreateDesktopIcon']) {
  $tasks[0] = '!' + $tasks[0]
}
if(!$additionalArgs['CBZassociation']) {
  $tasks[1] = '!' + $tasks[1]
}
if(!$additionalArgs['CB7association']) {
  $tasks[2] = '!' + $tasks[2]
}
if(!$additionalArgs['CBRassociation']) {
  $tasks[3] = '!' + $tasks[3]
}
$packageArgs['silentArgs'] += " /TASKS=`"$($tasks -join ' ')`""

Install-ChocolateyInstallPackage @packageArgs

& "$toolsDir\chocolateybeforemodify.ps1"

Remove-Item `
  -Path $packageArgs['file64'] `
  -ErrorAction SilentlyContinue `
  -Force