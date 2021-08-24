$ErrorActionPreference = 'Stop'
$toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = Join-Path $toolsDir 'showdate-0.1.1-win32.zip'
  fileFullPath64 = Join-Path $toolsDir 'showdate-0.1.1-win64.zip'
  destination    = $toolsDir
  validExitCodes = @(0)
}

Get-ChocolateyUnzip @packageArgs

$filesToRemove = @($packageArgs['fileFullPath'], $packageArgs['fileFullPath64'])
$filesToRemove | % { Remove-Item -Path $_ -ErrorAction SilentlyContinue -Force }
