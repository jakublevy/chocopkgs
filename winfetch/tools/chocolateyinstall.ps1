$ErrorActionPreference = 'Stop';
$toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

$binaryLocation = "$(Get-ToolsLocation)\winfetch"

New-Item `
  -Path $binaryLocation `
  -ItemType Directory `
  -Force

Move-Item `
  -Path "$toolsDir\winfetch.ps1" `
  -Destination $binaryLocation `
  -Force

Move-Item `
  -Path "$toolsDir\winfetch.bat" `
  -Destination $binaryLocation `
  -Force

$addionalArgs = Get-PackageParameters

if($null -eq $addionalArgs['AddToSystemPath'] -or $addionalArgs['AddToSystemPath'] -eq 'yes') {
  Install-ChocolateyPath -PathToInstall $binaryLocation -PathType Machine
}

if($addionalArgs['AddToUserPath'] -eq 'yes') {
  Install-ChocolateyPath -PathToInstall $binaryLocation -PathType User
}