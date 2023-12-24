$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$checksum_kcc = '8C469B07DE3E58D87C47497658052DECF22EFED3756A178C15D6EC3220A2A9E7'
$checksum_c2e = '98333B331C7097430C79D00D3175754E85D05D31829A65DE6A899B71C55BF4F0'
$checksum_c2p = '3FBA0B9771D3BDD1A3DDAC3F148F3906AA9A834DE766A9DCD84B1863724CA935'
$version = '5.6.5'

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
