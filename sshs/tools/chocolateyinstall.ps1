$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

Rename-Item `
  -Path "$toolsDir\sshs-windows-amd64.exe" `
  -NewName 'sshs.exe' `
  -Force