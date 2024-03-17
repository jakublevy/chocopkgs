$ErrorActionPreference = 'Stop'
$checksum64 = 'b315b8bccc28947c6dcf0fee4e5b69e12c64b8b987763cb238a408e1528d7218'
$version = '0.5.1'

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
