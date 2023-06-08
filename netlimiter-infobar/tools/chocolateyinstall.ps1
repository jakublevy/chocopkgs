$ErrorActionPreference = 'Stop'
$version  = '1.43.0'
$checksum = '389a0d915ad40d59b116d0838d53dcfdc6526af94181ccb8663f63c84bd65dc9'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE' #wrapped MSI
  url64         = "https://www.netlimiter.com/files/download/nl/NLInfoBar-$version.exe"
  softwareName  = "NetLimiter InfoBar*"
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = "/exenoui /qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0)
}

$winVersion = [Environment]::OsVersion.Version
if($winVersion.Major -ne 10) {
  Write-Warning 'Currently, only Windows 10 64-bit systems are supported.'
}

$additionalArgs = Get-PackageParameters
if($additionalArgs['InstallationPath']) {
  $packageArgs['silentArgs'] += " APPDIR=`"$($additionalArgs['InstallationPath'])`""
}

Install-ChocolateyPackage @packageArgs
