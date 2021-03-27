$ErrorActionPreference = 'Stop';
$toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)         

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = "$env:ChocolateyPackageName*"
  url           = "https://petr.olsak.net/ftp/olsak/vlna/oldbin/vlna32.exe"
  checksum      = '0ECB6B4284210AE430F7ECB4DF5713914D6455213118B8BE9302B243FEFBCADA'
  checksumType  = 'sha256' 
  fileFullPath  = "$toolsDir\vlna.exe"
}

Get-ChocolateyWebFile @packageArgs
