$ErrorActionPreference = 'Stop'
$version  = '1.2'
$checksum = '8CB416909934BB821246C95B8B8669826AC45AF303871FBE0ACAF01A6DF40463'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE' #wrapped MSI
  url64         = "https://www.netlimiter.com/files/download/nl4/NLInfoBar-$version.exe"
  softwareName  = "NetLimiter InfoBar*"
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = "/exenoui /qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0)
}

if((Get-OSArchitectureWidth -Compare 32) -or $env:ChocolateyForceX86) {
  Write-Warning 'Currently, only Windows 10 64-bit systems are supported.'
  Write-Error '32-bit is not supported.'
}

$winVersion = [Environment]::OsVersion.Version
if($winVersion.Major -ne 10) {
  Write-Warning 'Currently, only Windows 10 64-bit systems are supported.'
  Write-Error "Windows $($winVersion.Major) is not supported."
}

$additionalArgs = Get-PackageParameters
if($additionalArgs['InstallationPath']) {
  $packageArgs['silentArgs'] += " APPDIR=`"$($additionalArgs['InstallationPath'])`""
}

Install-ChocolateyPackage @packageArgs
