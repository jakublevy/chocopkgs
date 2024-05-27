$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$version  = '2024.1'
$checksum64 = 'de3a895305e981d62ff12d2e0ccc841da68e66d20bc4975dd29e0fff94abd214'

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
