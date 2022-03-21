$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileFullPath  = Join-Path $toolsDir 'steghide-0.5.1-win32.zip'
  destination   = $toolsDir
  validExitCodes= @(0)
}

Get-ChocolateyUnzip @packageArgs

Remove-Item `
  -Path "$toolsDir\bin" `
  -Recurse `
  -Force `
  -ErrorAction SilentlyContinue

Rename-Item `
  -Path "$toolsDir\steghide" `
  -NewName 'bin' `
  -Force

Remove-Item `
  -Path $packageArgs['fileFullPath'] `
  -ErrorAction SilentlyContinue `
  -Force