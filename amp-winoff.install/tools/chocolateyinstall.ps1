$ErrorActionPreference = 'Stop';
$checksum = '2891D5CD484791A8482865255333B8CF432A9D6DFB8705D724A825B85B64C891'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = 'https://www.ampsoft.net/files/WinOFFSetup.exe'
  softwareName  = 'AMP WinOFF*'
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = "/S"
  validExitCodes= @(0)
}

$additionalArgs = Get-PackageParameters
if($additionalArgs['InstallationPath']) {
  $packageArgs['silentArgs'] += " /D=$($additionalArgs['InstallationPath'])"
}

Install-ChocolateyPackage @packageArgs