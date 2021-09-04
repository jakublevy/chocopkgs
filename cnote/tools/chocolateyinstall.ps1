$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = Join-Path $toolsDir 'cnote_windows_386.exe.zip'
  fileFullPath64 = Join-Path $toolsDir 'cnote_windows_amd64.exe.zip'
  destination    = "$toolsDir\bin"
  validExitCodes = @(0)
}

Get-ChocolateyUnzip @packageArgs

$binary = (Get-ChildItem "$toolsDir\bin")[0].FullName

Rename-Item `
  -Path $binary `
  -NewName 'cnote.exe' `
  -Force

$filesToRemove = @($packageArgs['fileFullPath'], $packageArgs['fileFullPath64'])
$filesToRemove | % { Remove-Item -Path $_ -ErrorAction SilentlyContinue -Force }