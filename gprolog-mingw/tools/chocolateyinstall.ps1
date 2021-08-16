$ErrorActionPreference = 'Stop';
$toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'EXE'
  file           = Join-Path $toolsDir 'setup-gprolog-1.5.0-mingw-x86.exe'
  file64         = Join-Path $toolsDir 'setup-gprolog-1.5.0-mingw-x64.exe'
  softwareName   = 'GNU Prolog*'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
}

$addionalArgs = Get-PackageParameters
if($addionalArgs['InstallationPath']) {
  $packageArgs['silentArgs'] += " /DIR=`"$($addionalArgs['InstallationPath'])`""
}

$tasks = @('desktopicon', 'assocPl', 'assocPro', 'assocProlog')
if(!$addionalArgs['CreateDesktopIcon']) {
  $tasks[0] = '!' + $tasks[0]
}
if(!$addionalArgs['AssocPl']) {
  $tasks[1] = '!' + $tasks[1]
}
if(!$addionalArgs['AssocPro']) {
  $tasks[2] = '!' + $tasks[2]
}
if(!$addionalArgs['AssocProlog']) {
  $tasks[3] = '!' + $tasks[3]
}
$packageArgs['silentArgs'] += " /TASKS=`"$($tasks -join ' ')`""

Install-ChocolateyInstallPackage @packageArgs