$ErrorActionPreference = 'Stop'
$checksum64            = 'B5231184AEB9715EEA44F71C80598C2D448F3BBF5E5C14E49A63B8B94FFC5CEA'

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
