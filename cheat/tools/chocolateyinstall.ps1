$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileFullPath64= Join-Path $toolsDir 'cheat-windows-amd64.exe.zip'
  destination   = $toolsDir
  validExitCodes= @(0)
}

Get-ChocolateyUnzip @packageArgs

New-Item `
  -Path "$toolsDir\bin" `
  -ItemType Directory `
  -Force | Out-Null

Move-Item `
  -Path "$toolsDir\dist\cheat-windows-amd64.exe" `
  -Destination "$toolsDir\bin\cheat.exe" `
  -Force

$filesToRemove = @($packageArgs['fileFullPath64'], "$toolsDir\dist")
$filesToRemove | % { Remove-Item -Path $_ -ErrorAction SilentlyContinue -Force }
  