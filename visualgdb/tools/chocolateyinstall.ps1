$ErrorActionPreference = 'Stop';
$absUrl   = 'https://sysprogs.com/getfile/1528/VisualGDB-5.5r5-trial.msi'
$checksum = 'EADDCEC714CEF5A0D76C56DA8CCD6FD2CAC76A72283FA42324DB2DDE3F5D5A56'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'MSI'
  url           = $absUrl
  softwareName  = "$env:ChocolateyPackageName*"
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
