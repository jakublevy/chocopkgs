$ErrorActionPreference = 'Stop'
$toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = Join-Path $toolsDir 'brename_windows_386.exe.tar.gz'
  fileFullPath64 = Join-Path $toolsDir 'brename_windows_amd64.exe.tar.gz'
  destination    = $toolsDir
  validExitCodes = @(0)
}

Get-ChocolateyUnzip @packageArgs

$packageArgs['fileFullPath']   = $packageArgs['fileFullPath'].Replace('.gz', '')
$packageArgs['fileFullPath64'] = $packageArgs['fileFullPath64'].Replace('.gz', '')
$packageArgs['destination']    = "$toolsDir\bin"
Get-ChocolateyUnzip @packageArgs

Remove-Item `
  -Path "$toolsDir\*.tar" `
  -ErrorAction SilentlyContinue `
  -Force

Remove-Item `
  -Path "$toolsDir\*.gz" `
  -ErrorAction SilentlyContinue `
  -Force
