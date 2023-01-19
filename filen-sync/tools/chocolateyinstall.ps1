$ErrorActionPreference = 'Stop'
$checksum64            = '11451bdc52403f1118ec827ac55c3b0df90645d3a92beb8cf2a5153242f50213'

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
