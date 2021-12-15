$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath64 = Join-Path $toolsDir 'spotify-tui-windows.tar.gz'
  destination    = $toolsDir
  validExitCodes = @(0)
}

Get-ChocolateyUnzip @packageArgs

$packageArgs['fileFullPath64'] = $packageArgs['fileFullPath64'].Replace('.gz', '')
$packageArgs['destination']    = "$toolsDir\bin"
Get-ChocolateyUnzip @packageArgs

Remove-Item `
  -Path "$toolsDir\*.tar", "$toolsDir\*.gz" `
  -ErrorAction SilentlyContinue `
  -Force
