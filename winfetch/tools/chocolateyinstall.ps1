$ErrorActionPreference = 'Stop';
$toolsDir              = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$version               = '2.0.0'
$checksum              = '53EDA3231F7A556076E65B098FF48619739BA0FBEA518E4998B3615A318A218A'
$executableFullPath    = "$toolsDir\winfetch-$version\winfetch.ps1"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = "https://github.com/lptstr/winfetch/archive/refs/tags/v$version.zip"
  softwareName  = 'winfetch*'
  checksum      = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyPowershellCommand `
  -PackageName    "$($packageArgs['packageName']).powershell" `
  -PsFileFullPath $executableFullPath
