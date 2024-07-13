$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  file64        = Join-Path $toolsDir 'StrawberrySetup-1.0.23-msvc-x64.exe'
  softwareName  = 'Strawberry Music Player*'
  silentArgs    = "/S"
  validExitCodes= @(0)
}

$additionalArgs = Get-PackageParameters
if($additionalArgs['InstallDir']) {
  $packageArgs['silentArgs'] += " /D=$($additionalArgs['InstallDir'])"
}

& "$toolsDir\chocolateyuninstall.ps1"
Install-ChocolateyInstallPackage @packageArgs

Remove-Item `
  -Path $packageArgs['file64'] `
  -ErrorAction SilentlyContinue `
  -Force
