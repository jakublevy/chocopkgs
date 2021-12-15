$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = Join-Path $toolsDir 'r128gain_win32.7z'
  fileFullPath64 = Join-Path $toolsDir 'r128gain_win64.7z'
  destination    = $toolsDir
  validExitCodes = @(0)
}

Get-ChocolateyUnzip @packageArgs

Remove-Item `
  -Path $packageArgs['fileFullPath'], $packageArgs['fileFullPath64'] `
  -ErrorAction SilentlyContinue `
  -Force

New-Item `
  -Path "$toolsDir\r128gain*" `
  -ItemType File `
  -Name 'ffmpeg.exe.ignore'

Get-ChildItem "$toolsDir\r128gain*\lib\distutils\command\*" -Filter '*.exe' | % {
  New-Item `
    -Path $_.DirectoryName `
    -ItemType File `
    -Name "$($_.Name).ignore"
}
