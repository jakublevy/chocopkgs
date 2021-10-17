$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = Join-Path $toolsDir 'spicetify-2.7.1-windows-x32.zip'
  fileFullPath64 = Join-Path $toolsDir 'spicetify-2.7.1-windows-x64.zip'
  destination    = "$toolsDir\bin"
  validExitCodes = @(0)
}

Get-ChocolateyUnzip @packageArgs

$filesToRemove = @($packageArgs['fileFullPath'], $packageArgs['fileFullPath64'])
$filesToRemove | % { Remove-Item -Path $_ -ErrorAction SilentlyContinue -Force }