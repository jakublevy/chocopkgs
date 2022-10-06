$ErrorActionPreference = 'Stop'
$checksum64 = '86f26a23c82e133b927419073e9606c8e40186d3abb3eb8a51ed21a367b5c7dc'
$version = '0.4'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'ReeePlayer*'
  fileType      = 'EXE'
  url64         = "https://github.com/FilippVolodin/ReeePlayer/releases/download/v$version/ReeePlayer-$version-win-x64-installer.exe"
  checksum64    = $checksum64
  checksumType64= 'sha256'
  silentArgs    = '/S'
  validExitCodes= @(0)
}

$additionalArgs = Get-PackageParameters
if($additionalArgs['InstallationPath']) {
  $packageArgs['silentArgs'] += " /D=$($additionalArgs['InstallationPath'])"
}

Install-ChocolateyPackage @packageArgs
