$ErrorActionPreference = 'Stop';
$toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

Move-Item `
  -Path "$toolsDir\winfetch.ps1" `
  -Destination "$env:ChocolateyInstall\bin" `
  -Force

Move-Item `
  -Path "$toolsDir\winfetch.bat" `
  -Destination "$env:ChocolateyInstall\bin" `
  -Force