$ErrorActionPreference = 'Stop'
$checksum = 'ff611a285227f0bbddabd4b8b075f37be92cb285c465cc2597fd8a199cbf1a57'
$version  = '12.4.4'

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
