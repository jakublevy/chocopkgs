$ErrorActionPreference = 'Stop'
$toolsDir              = Split-Path -parent $MyInvocation.MyCommand.Definition
$version               = '2.0.0'
$checksum32            = 'C56622505110DC9358BACFB295F5CCFADF64E2F2930E4E7AE4B7FFB58C47D57A'
$checksum64            = 'DF7A489A7A257BC187D9AECC01368DB6A5B6E57BD0C061FCA385E3E046A8D31E'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  url           = "https://es-static.fbk.eu/tools/nuxmv/downloads/nuXmv-$version-win32.tar.gz"
  url64         = "https://es-static.fbk.eu/tools/nuxmv/downloads/nuXmv-$version-win64.tar.gz"
  checksum      = $checksum32
  checksum64    = $checksum64
  checksumType  = 'sha256'
  checksumType64= 'sha256'
  unzipLocation = $toolsDir
  validExitCodes= @(0)
}

Install-ChocolateyZipPackage @packageArgs

$packageArgsUntar = @{
  packageName   = $env:ChocolateyPackageName
  fileFullPath  = "$toolsDir\nuXmv-$version-win32.tar"
  fileFullPath64= "$toolsDir\nuXmv-$version-win64.tar"
  destination   = $toolsDir
  validExitCodes= @(0)
}

Get-ChocolateyUnzip @packageArgsUntar

Remove-Item `
  -Path "$toolsDir\*.tar" `
  -ErrorAction SilentlyContinue `
  -Force