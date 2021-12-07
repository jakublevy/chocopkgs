$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  file          = Join-Path $toolsDir 'StrawberrySetup-1.0.0-Qt6-x86.exe'
  file64        = Join-Path $toolsDir 'StrawberrySetup-1.0.0-Qt6-x64.exe'
  softwareName  = 'Strawberry Music Player*'
  silentArgs    = "/S"
  validExitCodes= @(0)
}

$additionalArgs = Get-PackageParameters
if($additionalArgs['InstallDir']) {
  $packageArgs['silentArgs'] += " /D=$($additionalArgs['InstallDir'])"
}

Install-ChocolateyInstallPackage @packageArgs

$filesToRemove = @($packageArgs['file'], $packageArgs['file64'])
$filesToRemove | % { Remove-Item -Path $_ -ErrorAction SilentlyContinue -Force }