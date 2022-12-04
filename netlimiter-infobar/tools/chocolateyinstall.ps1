$ErrorActionPreference = 'Stop'
$version  = '1.30'
$checksum = '4b15f4c0663e6a9f7ed7d40f3d63ebc730753af2f4ae7e883a30b3f545766c69'

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
}

$additionalArgs = Get-PackageParameters
if($additionalArgs['InstallationPath']) {
  $packageArgs['silentArgs'] += " APPDIR=`"$($additionalArgs['InstallationPath'])`""
}

Install-ChocolateyPackage @packageArgs
