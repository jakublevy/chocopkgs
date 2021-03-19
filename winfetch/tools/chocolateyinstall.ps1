﻿$ErrorActionPreference = 'Stop'
$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version               = '2.0.0'
$executableFullPath    = "$toolsDir\winfetch-$version\winfetch.ps1"
$url                   = "https://github.com/lptstr/winfetch/archive/refs/tags/v$version.zip"
$checksum              = '53EDA3231F7A556076E65B098FF48619739BA0FBEA518E4998B3615A318A218A'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = $url
  url64         = $url
  softwareName  = 'winfetch*'
  checksum      = $checksum
  checksum64    = $checksum
  checksumType  = 'sha256' 
}

Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyPowershellCommand `
  -PackageName    "$packageArgs.$packageName.powershell" `
  -PsFileFullPath $executableFullPath
