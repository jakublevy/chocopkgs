$ErrorActionPreference = 'Stop'
$version  = '1.42.0'
$checksum = 'b0223e3d6bd71c5ed8f1523b8bb048068be0111c0727535c6464af6c670985e5'

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
