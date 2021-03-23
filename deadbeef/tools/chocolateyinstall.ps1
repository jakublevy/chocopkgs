$ErrorActionPreference = 'Stop';
$url64      = 'https://sourceforge.net/projects/deadbeef/files/travis/windows/1.8.7/deadbeef-1.8.7-windows-x86_64.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url64bit      = $url64
  softwareName  = "$env:ChocolateyPackageName*"
  checksum64    = 'F219BF62C23739D59CFAB15CBA2B2BF9A9135064320E054EF27B0C0158F9597D'
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
