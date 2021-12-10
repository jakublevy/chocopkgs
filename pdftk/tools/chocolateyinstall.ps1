$ErrorActionPreference = 'Stop'
$toolsDir       = Split-Path -Parent $MyInvocation.MyCommand.Definition
$binaryLocation = "$(Get-ToolsLocation)\pdftk"

New-Item `
  -Path $binaryLocation `
  -ItemType Directory `
  -Force

Rename-Item `
  -Path "$toolsDir\pdftk-all.jar" `
  -NewName "$toolsDir\pdftk.jar" `
  -Force

$filesToMove = @('pdftk.bat', 'pdftk.jar')
$filesToMove | % { Move-Item -Path "$toolsDir\$_" -Destination $binaryLocation -Force }

$additionalArgs = Get-PackageParameters

if($null -eq $additionalArgs['AddToSystemPath'] -or $additionalArgs['AddToSystemPath'] -ne 'no') {
  Install-ChocolateyPath -PathToInstall $binaryLocation -PathType Machine
}

if($additionalArgs['AddToUserPath'] -eq 'yes') {
  Install-ChocolateyPath -PathToInstall $binaryLocation -PathType User
}

