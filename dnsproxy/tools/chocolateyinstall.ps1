﻿$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = Join-Path $toolsDir 'dnsproxy-windows-386-v0.46.4.zip'
  fileFullPath64 = Join-Path $toolsDir 'dnsproxy-windows-amd64-v0.46.4.zip'
  destination    = $toolsDir
  validExitCodes = @(0)
}

Get-ChocolateyUnzip @packageArgs

Remove-Item `
  -Path $packageArgs['fileFullPath'], $packageArgs['fileFullPath64'] `
  -ErrorAction SilentlyContinue `
  -Force

Move-Item `
  -Path "$toolsDir\windows-*" `
  -Destination "$toolsDir\bin" `
  -Force

