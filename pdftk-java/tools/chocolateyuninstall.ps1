$ErrorActionPreference = 'Stop'
$toolsDir       = Split-Path -parent $MyInvocation.MyCommand.Definition
$binaryLocation = "$(Get-ToolsLocation)\pdftk-java"

. "$toolsDir\Uninstall-ChocolateyPath.ps1"

Remove-Item `
    -Path $binaryLocation `
    -Recurse -Force

Uninstall-ChocolateyPath `
    -PathToUninstall $binaryLocation `
    -PathType All `
    -ErrorAction SilentlyContinue