$ErrorActionPreference = 'Stop';
$toolsDir = $(Split-Path -Parent $MyInvocation.MyCommand.Definition)

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileFullPath64= Join-Path $toolsDir 'Memento_Windows_x86_64.zip'
  destination   = $toolsDir
  validExitCodes= @(0)
}

Get-ChocolateyUnzip @packageArgs

Remove-Item `
  -Path $packageArgs['fileFullPath64'] `
  -ErrorAction SilentlyContinue `
  -Force

New-Item `
  -Name 'youtube-dl.exe.ignore' `
  -Path  "$toolsDir\Memento*\config" `
  -ItemType 'file'