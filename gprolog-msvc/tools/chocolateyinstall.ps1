$ErrorActionPreference = 'Stop'
$toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'EXE'
  file           = Join-Path $toolsDir 'setup-gprolog-1.5.0-msvc-x86.exe'
  file64         = Join-Path $toolsDir 'setup-gprolog-1.5.0-msvc-x64.exe'
  softwareName   = 'GNU Prolog*'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
}

$additionalArgs = Get-PackageParameters
if($additionalArgs['InstallationPath']) {
  $packageArgs['silentArgs'] += " /DIR=`"$($additionalArgs['InstallationPath'])`""
}

$tasks = @('desktopicon', 'assocPl', 'assocPro', 'assocProlog')
if(!$additionalArgs['CreateDesktopIcon']) {
  $tasks[0] = '!' + $tasks[0]
}
if(!$additionalArgs['AssocPl']) {
  $tasks[1] = '!' + $tasks[1]
}
if(!$additionalArgs['AssocPro']) {
  $tasks[2] = '!' + $tasks[2]
}
if(!$additionalArgs['AssocProlog']) {
  $tasks[3] = '!' + $tasks[3]
}
$packageArgs['silentArgs'] += " /TASKS=`"$($tasks -join ' ')`""

Install-ChocolateyInstallPackage @packageArgs

$filesToRemove = @($packageArgs['file'], $packageArgs['file64'])
$filesToRemove | % { Remove-Item -Path $_ -ErrorAction SilentlyContinue -Force }