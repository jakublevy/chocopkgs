$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -parent $MyInvocation.MyCommand.Definition
$version  = '3.0'

Remove-Item `
  -Path "$toolsDir\WinFLASHTool.exe" `
  -Force `
  -ErrorAction SilentlyContinue

Rename-Item `
  -Path "$toolsDir\WinFLASHTool-$version.exe" `
  -NewName 'WinFLASHTool.exe' `
  -Force