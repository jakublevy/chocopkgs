$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = Join-Path $toolsDir 'z3-4.14.0-x86-win.zip'
  fileFullPath64 = Join-Path $toolsDir 'z3-4.14.0-x64-win.zip'
  destination    = $toolsDir
  validExitCodes = @(0)
}

Get-ChocolateyUnzip @packageArgs

Remove-Item `
  -Path "$toolsDir\bin" `
  -Recurse -Force `
  -ErrorAction SilentlyContinue

Get-ChildItem "$toolsDir\z3-*-win" | % { Rename-Item -Path $_ -NewName 'bin' -Force }

Remove-Item `
  -Path $packageArgs['fileFullPath'], $packageArgs['fileFullPath64'] `
  -ErrorAction SilentlyContinue `
  -Force
