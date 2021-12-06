$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = Join-Path $toolsDir 'ddcpuid-0.19.1-windows-msvc-x86.zip'
  fileFullPath64 = Join-Path $toolsDir 'ddcpuid-0.19.1-windows-msvc-x86_64.zip'
  destination    = "$toolsDir\bin"
  validExitCodes = @(0)
}

Get-ChocolateyUnzip @packageArgs

$filesToRemove = @($packageArgs['fileFullPath'], $packageArgs['fileFullPath64'])
$filesToRemove | % { Remove-Item -Path $_ -ErrorAction SilentlyContinue -Force }
