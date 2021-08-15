$ErrorActionPreference = 'Stop';
$version    = '1.8.8'
$checksum64 = 'BABA51057247F64020C6F59078ED4E44FB46A585C29AB5028ABB86BAFCB5F6E1'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url64bit      = "https://sourceforge.net/projects/deadbeef/files/travis/windows/$version/deadbeef-$version-windows-x86_64.exe"
  softwareName  = "$env:ChocolateyPackageName*"
  checksum64    = $checksum64
  checksumType64= 'sha256'
  silentArgs    = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes= @(0)
}

$additionalArgs = Get-PackageParameters
if($additionalArgs['InstallationPath']) {
  $packageArgs['silentArgs'] += " /DIR=`"$($additionalArgs['InstallationPath'])`""
}

$tasks = @('desktopicon', 'association')
if(!$additionalArgs['CreateDesktopIcon']) {
  $tasks[0] = '!' + $tasks[0]
}
if(!$additionalArgs['AssociateAudioFiles']) {
  $tasks[1] = '!' + $tasks[1]
}
$packageArgs['silentArgs'] += " /TASKS=`"$($tasks -join ' ')`""

Install-ChocolateyPackage @packageArgs
