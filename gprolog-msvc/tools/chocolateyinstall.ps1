$ErrorActionPreference = 'Stop';
$version    = '1.4.5'
$checksum   = 'E625DECC0CEFBCB598CF6F0F88045C9B815F4F3864B260070395F1FF3D7E88CE'
$checksum64 = '66B3A5322A3BC483BAA4680B70CC6112BCA3B5329D42E6EA0096BC26B14D2CBA'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'EXE'
  url            = "http://www.gprolog.org/setup-gprolog-$version-msvc-x86.exe"
  url64bit       = "http://www.gprolog.org/setup-gprolog-$version-msvc-x64.exe"
  softwareName   = 'GNU Prolog*'
  checksum       = $checksum
  checksumType   = 'sha256'
  checksum64     = $checksum64
  checksumType64 = 'sha256'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
}

$addionalArgs = Get-PackageParameters
if($addionalArgs['InstallationPath']) {
  $packageArgs['silentArgs'] += " /DIR=`"$($addionalArgs['InstallationPath'])`""
}

$tasks = @('desktopicon', 'assocPl', 'assocPro', 'assocProlog')
if(!$addionalArgs['CreateDesktopIcon']) {
  $tasks[0] = '!' + $tasks[0]
}
if(!$addionalArgs['AssocPl']) {
  $tasks[1] = '!' + $tasks[1]
}
if(!$addionalArgs['AssocPro']) {
  $tasks[2] = '!' + $tasks[2]
}
if(!$addionalArgs['AssocProlog']) {
  $tasks[3] = '!' + $tasks[3]
}
$packageArgs['silentArgs'] += " /TASKS=`"$($tasks -join ' ')`""

Install-ChocolateyPackage @packageArgs
