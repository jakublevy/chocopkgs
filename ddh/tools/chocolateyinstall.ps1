$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = Join-Path $toolsDir 'ddh-2.0.1-windows-msvc-x86.zip'
  fileFullPath64 = Join-Path $toolsDir 'ddh-2.0.1-windows-msvc-x86_64.zip'
  destination    = "$toolsDir\bin"
  validExitCodes = @(0)
}

Get-ChocolateyUnzip @packageArgs

Remove-Item `
  -Path $packageArgs['fileFullPath'], $packageArgs['fileFullPath64'] `
  -ErrorAction SilentlyContinue `
  -Force
