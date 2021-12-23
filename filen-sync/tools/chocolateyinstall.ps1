$ErrorActionPreference = 'Stop'
$checksum64            = 'e15c67ad45b1492e79d809c7b6342cb60f3c71101b216a78a8ded16e3523711b'
$version               = '1.6.2'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url64         = "https://github.com/FilenCloudDienste/filen-desktop/releases/download/$version/filen-setup.exe"
  softwareName  = 'Filen Sync*'
  checksum64    = $checksum64
  checksumType64= 'sha256'
  silentArgs    = '/S'
  validExitCodes= @(0)
}

$additionalArgs = Get-PackageParameters
if($additionalArgs['InstallDir']) {
  $packageArgs['silentArgs'] += " /D=$($additionalArgs['InstallDir'])"
}

Install-ChocolateyPackage @packageArgs
