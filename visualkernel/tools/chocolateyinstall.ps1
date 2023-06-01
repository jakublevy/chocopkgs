$ErrorActionPreference = 'Stop'
$absUrl   = 'https://sysprogs.com/getfile/2040/VisualKernel-4.1-trial.msi'
$checksum = 'c6e816e82680adacc9d1a33be1568f354e3e2a1cc8c55f7cf694fd1583785960'

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
