$ErrorActionPreference = 'Stop';
$toolsDir = $(Split-Path -Parent $MyInvocation.MyCommand.Definition)
$checksum64 = '9CD16DB255586661B1F64421349696072179B66966D2EE32C9DD8748839D43A8'
$version = '0.1'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  url64         = "https://github.com/FilippVolodin/ReeePlayer/releases/download/v$version/ReeePlayer-$version-win-x64.zip"
  checksum64    = $checksum64
  checksumType64= 'sha256'
  unzipLocation = "$toolsDir\bin"
  validExitCodes= @(0)
}

Install-ChocolateyZipPackage @packageArgs