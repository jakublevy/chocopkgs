$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileFullPath64= Join-Path $toolsDir 'cheat-windows-amd64.exe.zip'
  destination   = $toolsDir
  validExitCodes= @(0)
}

Get-ChocolateyUnzip @packageArgs

Rename-Item `
  -Path "$toolsDir\cheat-windows-amd64.exe" `
  -NewName "$toolsDir\cheat.exe" `
  -Force

Remove-Item `
  -Path $packageArgs['fileFullPath64'] `
  -ErrorAction SilentlyContinue `
  -Force
