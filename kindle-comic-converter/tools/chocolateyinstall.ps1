$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$checksum_kcc = 'AC6A259A872166B1C690410FED9D5F8AB750B31BD9B358807C56CBCC01402B5D'
$checksum_c2e = '139B040A24E3214842DE694805C0BE96DD53490B95418134F978EFFB886AE37E'
$checksum_c2p = '79A26468382779ED960882EF86F6C0C3C3530BC126C12BC8B42E4135AF372220'
$version = '11.3.1'

$packageArgsCommon = @{
  packageName   = $env:ChocolateyPackageName
  checksumType64= 'sha256'
  validExitCodes= @(0)
}

$shortcutArgs = @{
  targetPath  = "$toolsDir\bin\kcc.exe"
}

$kccArgs = @{
  url64        = "https://github.com/ciromattia/kcc/releases/download/v$version/KCC_$version.exe"
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
