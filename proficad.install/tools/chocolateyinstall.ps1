$ErrorActionPreference = 'Stop'
$checksum = '86678e1b92920dfb744cacacdb68a4c39bb5d05de1b4b4b8abae2c5984c24432'
$version  = '14.0.2'

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
