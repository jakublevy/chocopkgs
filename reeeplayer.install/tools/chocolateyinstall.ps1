$ErrorActionPreference = 'Stop'
$checksum64 = '31f2faa4ea193a84789198c99d40e3bec5a6c9fbb0198b1ab6763ac4cba26834'
$version = '0.5'

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
