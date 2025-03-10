$ErrorActionPreference = 'Stop'
$absUrl   = 'http://eu.cdn.sysprogs.com/2326/VisualGDB-6.0r8-trial.msi'
$checksum = 'a6e7d831e1299d576d08e80888350930a53d8051da7c93a7417483414f847a1f'

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
