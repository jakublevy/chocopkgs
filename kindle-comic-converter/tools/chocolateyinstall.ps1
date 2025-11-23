$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$checksum_kcc = '4EB9086151CC40BF4A31719285F31760EE836DA03CD92BC5B674AD9777F7F751'
$checksum_c2e = 'D7DE4B1A423E0803B2421930ABADC4280BAB011909191BEAD57ACE68ABC739AA'
$checksum_c2p = '2C693730253BFF0DDC881411D8DB3429EB05A4C103FA25113F1C95824B049E6D'
$version = '9.2.2'

$packageArgsCommon = @{
  packageName   = $env:ChocolateyPackageName
  checksumType64= 'sha256'
  validExitCodes= @(0)
}

$shortcutArgs = @{
  targetPath  = "$toolsDir\bin\kcc.exe"
}

$kccArgs = @{
  url64        = "https://github.com/ciromattia/kcc/releases/download/v$version/kcc_$version.exe"
  fileFullPath = "$toolsDir\bin\kcc.exe"
  checksum64   = $checksum_kcc
}

$c2eArgs = @{
  url64        = "https://github.com/ciromattia/kcc/releases/download/v$version/kcc_c2e_$version.exe"
  fileFullPath = "$toolsDir\bin\kcc-c2e.exe"
  checksum64   = $checksum_c2e
}

$c2pArgs = @{
  url64        = "https://github.com/ciromattia/kcc/releases/download/v$version/kcc_c2p_$version.exe"
  fileFullPath = "$toolsDir\bin\kcc-c2p.exe"
  checksum64   = $checksum_c2p
}

Get-ChocolateyWebFile @packageArgsCommon @kccArgs
Get-ChocolateyWebFile @packageArgsCommon @c2eArgs
Get-ChocolateyWebFile @packageArgsCommon @c2pArgs

New-Item `
  -Name 'kcc.exe.ignore' `
  -Path  "$toolsDir\bin" `
  -ItemType 'file' `
  -Force

$additionalArgs = Get-PackageParameters
if($null -eq $additionalArgs['AddToStartMenu'] -or $additionalArgs['AddToStartMenu'] -eq "allusers") {
  Install-ChocolateyShortcut `
    -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Kindle Comic Converter.lnk" `
    @shortcutArgs
}
elseif($additionalArgs['AddToStartMenu'] -eq "curruser") {
  Install-ChocolateyShortcut `
    -ShortcutFilePath "$env:AppData\Microsoft\Windows\Start Menu\Programs\Kindle Comic Converter.lnk" `
    @shortcutArgs
}
