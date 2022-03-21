$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -parent $MyInvocation.MyCommand.Definition

Remove-Item `
  -Path "$toolsDir\gomuks.exe" `
  -Force `
  -ErrorAction SilentlyContinue

Rename-Item `
  -Path "$toolsDir\gomuks-windows-amd64.exe" `
  -NewName 'gomuks.exe' `
  -Force
