$ErrorActionPreference = 'Stop'
$checksum64            = 'bcf3a8f0c6b92b1447dd3c3b00fcdffccaf0308342b9c25255dc3af0b95d09ea'

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
