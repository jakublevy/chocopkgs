$ErrorActionPreference = 'Stop';
$toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)         
$version  = '2.0.0'
$checksum = 'EF7CADAB4CEC7E1BFE6CFABEF3AF36E3F0F8ABC1F53DCF5E3B6E06AB4FE94179'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  url           = "https://raw.githubusercontent.com/kiedtl/winfetch/v$version/winfetch.ps1"
  checksum      = $checksum
  checksumType  = 'sha256' 
  psFileFullPath= "$toolsDir\winfetch.ps1"
}

Install-ChocolateyPowershellCommand @packageArgs
