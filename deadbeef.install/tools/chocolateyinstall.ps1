$ErrorActionPreference = 'Stop';
$toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = "DeaDBeeF*"
  fileType      = 'EXE'
  file64        = Join-Path $toolsDir 'deadbeef-1.8.8-windows-x86_64.exe'
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0)
}

$additionalArgs = Get-PackageParameters
if($additionalArgs['InstallationPath']) {
  $packageArgs['silentArgs'] += " /DIR=`"$($additionalArgs['InstallationPath'])`""
}

$tasks = @('desktopicon', 'association')
if(!$additionalArgs['CreateDesktopIcon']) {
  $tasks[0] = '!' + $tasks[0]
}
if(!$additionalArgs['AssociateAudioFiles']) {
  $tasks[1] = '!' + $tasks[1]
}
$packageArgs['silentArgs'] += " /TASKS=`"$($tasks -join ' ')`""

Install-ChocolateyInstallPackage @packageArgs