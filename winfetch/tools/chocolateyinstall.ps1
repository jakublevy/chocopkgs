$ErrorActionPreference = 'Stop';
$toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$version  = '2.2.0'
$checksum = '569A4A9C87948A663540B93FBF3B8CC4E283A3F7E64C9A5D602C95B4FB38C3BC'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  url           = "https://raw.githubusercontent.com/kiedtl/winfetch/v$version/winfetch.ps1"
  checksum      = $checksum
  checksumType  = 'sha256' 
  fileFullPath  = "$env:ChocolateyInstall\bin\winfetch.ps1"
  forceDownload = $true
}

Get-ChocolateyWebFile @packageArgs

Move-Item `
  -Path "$toolsDir\winfetch.bat" `
  -Destination "$env:ChocolateyInstall\bin" `
  -Force