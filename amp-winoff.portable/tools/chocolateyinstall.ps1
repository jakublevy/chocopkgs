$ErrorActionPreference = 'Stop';
$toolsDir = $(Split-Path -Parent $MyInvocation.MyCommand.Definition)

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileFullPath  = Join-Path $toolsDir 'WinOFF.zip'
  destination   = "$toolsDir\bin"
  validExitCodes= @(0)
}

Get-ChocolateyUnzip @packageArgs

$shimArgs = @{
  path       = $packageArgs['destination']
  itemType   = 'file'
  errorAction= 'SilentlyContinue'
}

New-Item `
  -Name 'WinOFF_admin.exe.ignore' `
  @shimArgs

New-Item `
  -Name 'WinOFF_guardian.exe.ignore' `
  @shimArgs

New-Item `
  -Name 'WinOFF_launcher.exe.ignore' `
  @shimArgs
