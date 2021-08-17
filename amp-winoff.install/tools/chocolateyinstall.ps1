$ErrorActionPreference = 'Stop';
$toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  file          = Join-Path $toolsDir 'WinOFFSetup.exe'
  softwareName  = 'AMP WinOFF*'
  silentArgs    = "/S"
  validExitCodes= @(0)
}

$additionalArgs = Get-PackageParameters
if($additionalArgs['InstallationPath']) {
  $packageArgs['silentArgs'] += " /D=$($additionalArgs['InstallationPath'])"
}

Install-ChocolateyInstallPackage @packageArgs