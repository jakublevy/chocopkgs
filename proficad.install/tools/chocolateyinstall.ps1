$ErrorActionPreference = 'Stop';
$checksum = 'D82E5273C7A7AC85F9CF46DEF6EDC458C5A2CBE8D129AB202969D15219E639AB'
$version  = '11.2.2'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'EXE'
  url            = "https://www.proficad.com/down/$($version.Split('.')[0])/setup_full.exe"
  softwareName   = 'Kindle Comic Converter*'
  checksum       = $checksum
  checksumType   = 'sha256'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
}

$addionalArgs = Get-PackageParameters

if($addionalArgs['InstallationPath']) {
  $path = $addionalArgs['InstallationPath']
  $packageArgs['silentArgs'] += " /DIR=""$path"""
}

Install-ChocolateyPackage @packageArgs