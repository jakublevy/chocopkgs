$ErrorActionPreference = 'Stop'
$toolsDir              = Split-Path -Parent $MyInvocation.MyCommand.Definition
$removeFile            = "$toolsDir\sshs-windows-386.exe"
$renameFile            = "$toolsDir\sshs-windows-amd64.exe"

if((Get-OSArchitectureWidth -Compare 32) -or $env:ChocolateyForceX86) {
  $removeFile = "$toolsDir\sshs-windows-amd64.exe"
  $renameFile = "$toolsDir\sshs-windows-386.exe"
}

Remove-Item `
  -Path "$toolsDir\sshs.exe", $removeFile `
  -Force `
  -ErrorAction SilentlyContinue

Rename-Item `
  -Path $renameFile `
  -NewName 'sshs.exe' `
  -Force