$ErrorActionPreference = 'Stop'
$checksum64            = 'acd621eaf21c3f0763ca44cc9d31cb2e1c7782eab3ec298d8e0dd5d040e0bd84'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url64         = 'https://cdn.filen.io/desktop/release/filen_x64.exe'
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
