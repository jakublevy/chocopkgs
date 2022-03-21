$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

Remove-Item `
  -Path "$toolsDir\sshs.exe" `
  -Force `
  -ErrorAction SilentlyContinue

Rename-Item `
  -Path "$toolsDir\sshs-windows-amd64.exe" `
  -NewName 'sshs.exe' `
  -Force