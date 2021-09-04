$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileFullPath64= Join-Path $toolsDir 'deadbeef-1.8.8-windows-x86_64.zip'
  destination   = Get-ToolsLocation
  validExitCodes= @(0)
}

Get-ChocolateyUnzip @packageArgs

Remove-Item `
  -Path $packageArgs['fileFullPath64'] `
  -ErrorAction SilentlyContinue `
  -Force

$additionalArgs = Get-PackageParameters
if($additionalArgs['AddToSystemPath'] -eq 'yes') {
  Install-ChocolateyPath -PathToInstall "$($packageArgs['destination'])\deadbeef-x86_64" -PathType Machine
}

if($null -eq $additionalArgs['AddToUserPath'] -or $additionalArgs['AddToUserPath'] -ne 'no') {
  Install-ChocolateyPath -PathToInstall "$($packageArgs['destination'])\deadbeef-x86_64" -PathType User
}