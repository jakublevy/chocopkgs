$ErrorActionPreference = 'Stop'
$toolsDir       = Split-Path -parent $MyInvocation.MyCommand.Definition
$binaryLocation = "$(Get-ToolsLocation)\deadbeef-x86_64"

. "$toolsDir\Uninstall-ChocolateyPath.ps1"

Remove-Item `
    -Path $binaryLocation `
    -ErrorAction SilentlyContinue `
    -Recurse -Force

Uninstall-ChocolateyPath `
    -PathToUninstall $binaryLocation `
    -PathType All `
    -ErrorAction SilentlyContinue
