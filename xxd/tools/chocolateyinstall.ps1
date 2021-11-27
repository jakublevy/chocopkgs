$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileFullPath  = Join-Path $toolsDir 'xxd-1.11_win32(static).zip'
  destination   = "$toolsDir"
  validExitCodes= @(0)
}

Get-ChocolateyUnzip @packageArgs

New-Item `
  -Path "$toolsDir\bin" `
  -ItemType Directory `
  -Force | Out-Null

Move-Item `
  -Path "$toolsDir\xxd-*_win32\xxd.exe" `
  -Destination "$toolsDir\bin" `
  -Force

$filesToRemove = @($packageArgs['fileFullPath'], "$toolsDir\xxd-*_win32")
$filesToRemove | % { Remove-Item -Path $_ -ErrorAction SilentlyContinue -Force }
