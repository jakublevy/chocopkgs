$ErrorActionPreference = 'Stop'
$absUrl   = 'https://sysprogs.com/getfile/1832/VisualGDB-5.6r5-trial.msi'
$checksum = 'a2ca64df1dcb0bda567f1d8069e0aac31011a3ebf6f6b595cab04d235d9e1be8'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'MSI'
  url           = $absUrl
  softwareName  = "$env:ChocolateyPackageName*"
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)
}

$additionalArgs = Get-PackageParameters
if($additionalArgs['InstallDir']) {
  $packageArgs['silentArgs'] += " INSTALLFOLDER=`"$($additionalArgs['InstallDir'])`""
}

Install-ChocolateyPackage @packageArgs
