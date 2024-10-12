$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileFullPath64= Join-Path $toolsDir 'xh-v0.23.0-x86_64-pc-windows-msvc.zip'
  destination   = $toolsDir
  validExitCodes= @(0)
}

Get-ChocolateyUnzip @packageArgs

$xhFolder = $packageArgs['fileFullPath64'].Replace('.zip', '')

Copy-Item `
  -Path "$xhFolder\xh.exe" `
  -Destination "$xhFolder\xhs.exe" `
  -Force

Remove-Item `
  -Path $packageArgs['fileFullPath64'] `
  -ErrorAction SilentlyContinue `
  -Force
