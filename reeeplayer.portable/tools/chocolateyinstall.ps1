$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$checksum64 = '64528118693a7d13afcd83d7901d6959fbf3a55389f1a2a52ebf686cf7827c25'
$version = '0.2'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  url64         = "https://github.com/FilippVolodin/ReeePlayer/releases/download/v$version/ReeePlayer-$version-win-x64.zip"
  checksum64    = $checksum64
  checksumType64= 'sha256'
  unzipLocation = "$toolsDir\bin"
  validExitCodes= @(0)
}

Install-ChocolateyZipPackage @packageArgs
