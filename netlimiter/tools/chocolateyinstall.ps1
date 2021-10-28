$ErrorActionPreference = 'Stop'
$version  = '4.1.12.0'
$checksum = '21a59ecf6294dd93fa7a7cbbeccb6723088b4356405be8a41fab268a7ced3869'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE' #wrapped MSI
  url           = "https://www.netlimiter.com/files/download/nl4/netlimiter-$version.exe"
  softwareName  = "$env:ChocolateyPackageName*"
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = "/exenoui /qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0)
}

$additionalArgs = Get-PackageParameters
if($additionalArgs['InstallationPath']) {
  $packageArgs['silentArgs'] += " APPDIR=`"$($additionalArgs['InstallationPath'])`""
}

Install-ChocolateyPackage @packageArgs
