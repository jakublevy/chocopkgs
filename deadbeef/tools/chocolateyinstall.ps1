$ErrorActionPreference = 'Stop';
$version    = '1.8.7'
$checksum64 = 'F219BF62C23739D59CFAB15CBA2B2BF9A9135064320E054EF27B0C0158F9597D'

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
