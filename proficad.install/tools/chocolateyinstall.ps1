$ErrorActionPreference = 'Stop'
$checksum = '9099b77ec83aefdd564a3c4f045bfc5b2eef80fed39cfbd1cf038645ecb59e2b'
$version  = '12.3.2'

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
