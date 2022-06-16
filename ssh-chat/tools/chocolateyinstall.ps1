$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = Join-Path $toolsDir 'ssh-chat-windows_386.tgz'
  destination    = $toolsDir
  validExitCodes = @(0)
}

Get-ChocolateyUnzip @packageArgs

$packageArgs['fileFullPath']   = $packageArgs['fileFullPath'].Replace('.tgz', '.tar')
Get-ChocolateyUnzip @packageArgs

Remove-Item `
  -Path "$toolsDir\*.tar", "$toolsDir\*.tgz" `
  -ErrorAction SilentlyContinue `
  -Force
