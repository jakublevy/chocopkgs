$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$checksum_kcc = '8614F444CB5BED1C5909B8496369D6B868AD73AB475AE5DDEEF7D332445A60FE'
$checksum_c2e = '027A06B3C8BBC03FEAC5EA4290B4056115E52EE39D2553559F534734C6AFE8F9'
$checksum_c2p = 'F39C30146DB6736A114127F801FA2E52F4C071FD1C46A3F4A60C3F4EE5D59B47'
$version = '6.3.1'

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
