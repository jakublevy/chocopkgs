$ErrorActionPreference = 'Stop';
$toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)         
$version  = '2.1.0'
$checksum = '3DFAF59FCF239C87D47E4921DA31E520E7769FA5521763E4CE1D38E7C76A73C0'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  url           = "https://raw.githubusercontent.com/kiedtl/winfetch/v$version/winfetch.ps1"
  checksum      = $checksum
  checksumType  = 'sha256' 
  psFileFullPath= "$toolsDir\winfetch.ps1"
}

Install-ChocolateyPowershellCommand @packageArgs
