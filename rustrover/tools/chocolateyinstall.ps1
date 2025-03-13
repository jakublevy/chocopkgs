$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$version  = '2024.3.7'
$checksum64 = '169654538784645e47f4ce9f5c0b3e589c9d74140988a8940440bf11280949ec'

$silentConfig = "$toolsDir\silent.config"
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url64         = "https://download-cdn.jetbrains.com/rustrover/RustRover-$version.exe"
  softwareName  = 'RustRover*'
  checksum64    = $checksum64
  checksumType64= 'sha256'
  silentArgs    = "/S /CONFIG=`"$silentConfig`""
  validExitCodes= @(0)
}

$additionalArgs = Get-PackageParameters
if($additionalArgs['DesktopIcon']) {
  (Get-Content $silentConfig | % { $_ -replace "launcher64=.*", "launcher64=1" }) | Set-Content $silentConfig
}
if($additionalArgs['AddBinToPath']) {
  (Get-Content $silentConfig | % { $_ -replace "updatePATH=.*", "updatePATH=1" }) | Set-Content $silentConfig
}
if($additionalArgs['AddToContextMenu']) {
  (Get-Content $silentConfig | % { $_ -replace "updateContextMenu=.*", "updateContextMenu=1" }) | Set-Content $silentConfig
}
if($additionalArgs['CreateFileAssoc']) {
  (Get-Content $silentConfig | % { $_ -replace ".rs=.*", ".rs=1" }) | Set-Content $silentConfig
}

if($additionalArgs['InstallDir']) {
  $packageArgs['silentArgs'] += " /D=$($additionalArgs['InstallDir'])"
}


Install-ChocolateyPackage @packageArgs
