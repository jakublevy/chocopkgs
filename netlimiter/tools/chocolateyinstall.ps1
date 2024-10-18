$ErrorActionPreference = 'Stop'
$version  = '5.3.18.0'
$checksum = '99ce75543755df63697610e00ce334564ce4d931d726ffb57d65a8a2679298de'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE' #wrapped MSI
  url           = "https://www.netlimiter.com/files/download/nl/netlimiter-$version.exe"
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
