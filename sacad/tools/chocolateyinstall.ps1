$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = Join-Path $toolsDir 'sacad_win32.7z'
  fileFullPath64 = Join-Path $toolsDir 'sacad_win64.7z'
  destination    = $toolsDir
  validExitCodes = @(0)
}

Get-ChocolateyUnzip @packageArgs

Remove-Item `
  -Path "$toolsDir\bin" `
  -Recurse `
  -Force `
  -ErrorAction SilentlyContinue

Move-Item -Path "$toolsDir\sacad-win*" -Destination "$toolsDir\bin" -Force

Remove-Item `
  -Path $packageArgs['fileFullPath'], $packageArgs['fileFullPath64'] `
  -ErrorAction SilentlyContinue `
  -Force
