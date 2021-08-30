$ErrorActionPreference = 'Stop'
$toolsDir       = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$binaryLocation = "$(Get-ToolsLocation)\winfetch"

New-Item `
  -Path $binaryLocation `
  -ItemType Directory `
  -Force

$filesToMove = @('winfetch.ps1', 'winfetch.bat')
$filesToMove | % { Move-Item -Path "$toolsDir\$_" -Destination $binaryLocation -Force }

$additionalArgs = Get-PackageParameters

if($null -eq $additionalArgs['AddToSystemPath'] -or $additionalArgs['AddToSystemPath'] -ne 'no') {
  Install-ChocolateyPath -PathToInstall $binaryLocation -PathType Machine
}

if($additionalArgs['AddToUserPath'] -eq 'yes') {
  Install-ChocolateyPath -PathToInstall $binaryLocation -PathType User
}