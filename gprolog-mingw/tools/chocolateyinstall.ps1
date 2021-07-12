$ErrorActionPreference = 'Stop';
$version    = '1.5.0'
$checksum   = '9C7AACD3D47DA7603069B995E2FABFF0288DC308CEA2461D439EDD8992004C3B'
$checksum64 = 'B32B9C6BDE2CB97D459C197762AB8ADE98DAD19D64E6BFB4FF68F035BBF7BA20'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'EXE'
  url            = "http://www.gprolog.org/setup-gprolog-$version-mingw-x86.exe"
  url64bit       = "http://www.gprolog.org/setup-gprolog-$version-mingw-x64.exe"
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
