$ErrorActionPreference = 'Stop'
$toolsDir              = Split-Path -parent $MyInvocation.MyCommand.Definition
$removeFile            = "$toolsDir\rcedit-x86.exe"
$renameFile            = "$toolsDir\rcedit-x64.exe"

if((Get-OSArchitectureWidth -Compare 32) -or $env:ChocolateyForceX86) {
  $removeFile = "$toolsDir\rcedit-x64.exe"
  $renameFile = "$toolsDir\rcedit-x86.exe"
}

Remove-Item `
  -Path $removeFile `
  -ErrorAction SilentlyContinue `
  -Force

Rename-Item `
  -Path $renameFile `
  -NewName 'rcedit.exe' `
  -Force