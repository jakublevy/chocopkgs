$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$version  = '2025.1.3'
$checksum64 = 'e44ee79242590d769eb368dcc73e5876b4dd30e473143db4b70a143d977c52ce'

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
