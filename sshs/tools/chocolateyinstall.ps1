$ErrorActionPreference = 'Stop'
$toolsDir              = Split-Path -Parent $MyInvocation.MyCommand.Definition
$renameFile            = "$toolsDir\sshs-windows-amd64.exe"

Rename-Item `
  -Path $renameFile `
  -NewName 'sshs.exe' `
  -Force