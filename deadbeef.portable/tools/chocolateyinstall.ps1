$ErrorActionPreference = 'Stop';
$toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

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

$addionalArgs = Get-PackageParameters
if($addionalArgs['AddToSystemPath'] -eq 'yes') {
  Install-ChocolateyPath -PathToInstall "$($packageArgs['destination'])\deadbeef-x86_64" -PathType Machine
}

if($null -eq $addionalArgs['AddToUserPath'] -or $addionalArgs['AddToUserPath'] -eq 'yes') {
  Install-ChocolateyPath -PathToInstall "$($packageArgs['destination'])\deadbeef-x86_64" -PathType User
}