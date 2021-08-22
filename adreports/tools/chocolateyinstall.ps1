$ErrorActionPreference = 'Stop';
$toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = Join-Path $toolsDir 'adreports-1.4.7-win32.zip'
  fileFullPath64 = Join-Path $toolsDir 'adreports-1.4.7-win64.zip'
  destination    = "$toolsDir\bin"
  validExitCodes = @(0)
}

Get-ChocolateyUnzip @packageArgs

Remove-Item `
  -Path $packageArgs['fileFullPath'] `
  -ErrorAction SilentlyContinue `
  -Force

Remove-Item `
  -Path $packageArgs['fileFullPath64'] `
  -ErrorAction SilentlyContinue `
  -Force
