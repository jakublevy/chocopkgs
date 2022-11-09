$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -parent $MyInvocation.MyCommand.Definition

Move-Item `
  -Path "$toolsDir\gomuks-windows-amd64.exe" `
  -Destination 'gomuks.exe' `
  -Force
