$ErrorActionPreference = 'Stop';
$version = '4.1.7.0'
$url     = "https://www.netlimiter.com/files/download/nl4/netlimiter-$version.exe"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE' #wrapped MSI
  url           = $url
  softwareName  = "$env:ChocolateyPackageName*"
  checksum      = 'FF75B7788A090C4BBC7BFA0D83917B36909AD40611DD1EEE53B50E4CC68C276E'
  checksumType  = 'sha256'
  silentArgs    = "/exenoui /qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0)
}

$additionalArgs = Get-PackageParameters
if($additionalArgs['InstallationPath']) {
  $packageArgs['silentArgs'] += " APPDIR=`"$($additionalArgs['InstallationPath'])`""
}

Install-ChocolateyPackage @packageArgs