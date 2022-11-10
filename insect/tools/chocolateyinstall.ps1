$ErrorActionPreference = 'Stop'
$toolsDir              = Split-Path -Parent $MyInvocation.MyCommand.Definition
$removeFile            = "$toolsDir\insect-windows-x86.exe"
$renameFile            = "$toolsDir\insect-windows-x64.exe"

if((Get-OSArchitectureWidth -Compare 32) -or $env:ChocolateyForceX86) {
  $removeFile = "$toolsDir\insect-windows-x64.exe"
  $renameFile = "$toolsDir\insect-windows-x86.exe"
}

Remove-Item `
  -Path "$toolsDir\insect.exe", $removeFile `
  -Force `
  -ErrorAction SilentlyContinue

Rename-Item `
  -Path $renameFile `
  -NewName 'insect.exe' `
  -Force