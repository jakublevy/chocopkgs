$ErrorActionPreference = 'Stop'
$absUrl   = 'http://eu.cdn.sysprogs.com/1897/VisualGDB-5.6r7-trial.msi'
$checksum = 'd5d5f5c555a84c2e130a91c316d39be965ef7261bc212518f61b7b96e1b43b03'

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
