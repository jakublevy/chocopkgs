$ErrorActionPreference = 'Stop';
$version    = '1.5.0'
$checksum   = 'BA8BC2605F419FC6E72CFA13D20F3459FD2C492D6152648259AF1173C88CD59A'
$checksum64 = 'F6D3CE18FC739377CF002E53A9A660B1DDE62AC94B8EF95587A46B466A16735A'

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
