$ErrorActionPreference = 'Stop'
$checksum = 'ff0cc1d0defd7b989cfd794f81e38f5fadb8348a57c14db996079fe66e43980a'
$version  = '11.4.1'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'EXE'
  url            = "https://www.proficad.com/down/$($version.Split('.')[0])/setup_full.exe"
  softwareName   = 'ProfiCAD*'
  checksum       = $checksum
  checksumType   = 'sha256'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
}

$additionalArgs = Get-PackageParameters

if($additionalArgs['InstallationPath']) {
  $path = $additionalArgs['InstallationPath']
  $packageArgs['silentArgs'] += " /DIR=""$path"""
}

Install-ChocolateyPackage @packageArgs
