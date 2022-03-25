$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  file          = Join-Path $toolsDir 'StrawberrySetup-1.0.3-mingw-x86.exe'
  file64        = Join-Path $toolsDir 'StrawberrySetup-1.0.3-msvc-x64.exe'
  softwareName  = 'Strawberry Music Player*'
  silentArgs    = "/S"
  validExitCodes= @(0)
}

$additionalArgs = Get-PackageParameters
if($additionalArgs['InstallDir']) {
  $packageArgs['silentArgs'] += " /D=$($additionalArgs['InstallDir'])"
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item `
  -Path $packageArgs['file'], $packageArgs['file64'] `
  -ErrorAction SilentlyContinue `
  -Force
