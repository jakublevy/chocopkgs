$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileFullPath64= Join-Path $toolsDir 'cheat-windows-amd64.exe.zip'
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
  -Path "$toolsDir\dist" `
  -NewName "$toolsDir\bin" `
  -Force

Rename-Item `
  -Path "$toolsDir\bin\cheat-windows-amd64.exe" `
  -NewName "$toolsDir\bin\cheat.exe" `
  -Force

Remove-Item `
  -Path $packageArgs['fileFullPath64'] `
  -ErrorAction SilentlyContinue `
  -Force
