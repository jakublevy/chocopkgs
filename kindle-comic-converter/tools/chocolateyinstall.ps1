$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$checksum_kcc = '93B5132E6BC4A159910AB534344E3769FE606C7177BB8A75E16CFA3D89D0619D'
$checksum_c2e = 'B1072B84633E7B8D4CDCF0855634A37651AEA366CBF852B38D00A2FB66248789'
$checksum_c2p = 'D31602A6A2F81908A875ED5BA06E65897B0B8DA26062750841D1EA7205D38020'
$version = '7.2.3'

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
