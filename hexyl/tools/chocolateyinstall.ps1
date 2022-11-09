$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = Join-Path $toolsDir 'hexyl-v0.10.0-i686-pc-windows-msvc.zip'
  fileFullPath64 = Join-Path $toolsDir 'hexyl-v0.10.0-x86_64-pc-windows-msvc.zip'
  destination    = $toolsDir
  validExitCodes = @(0)
}

Get-ChocolateyUnzip @packageArgs

Remove-Item `
  -Path $packageArgs['fileFullPath'], $packageArgs['fileFullPath64'], "$toolsDir\bin" `
  -ErrorAction SilentlyContinue `
  -Force

Get-ChildItem $toolsDir | Where-Object name -match 'hexyl' | Rename-Item -NewName 'bin' -Force