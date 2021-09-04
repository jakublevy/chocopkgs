$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -parent $MyInvocation.MyCommand.Definition

Rename-Item `
  -Path "$toolsDir\gomuks-windows-amd64.exe" `
  -NewName 'gomuks.exe' `
  -Force
