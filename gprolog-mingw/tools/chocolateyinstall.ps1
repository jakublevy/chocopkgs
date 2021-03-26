$ErrorActionPreference = 'Stop';
$version    = '1.4.5'
$checksum   = 'F4D0D3E51C3E006EE4376E4130917D25C48C0135038475CEA05488D333359502'
$checksum64 = '2E32877B00D53F49F3C4707940DD029BA5DF02C4C69DC652F4B98DE8F11FFEB8'

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
