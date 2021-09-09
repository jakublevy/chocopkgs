$ErrorActionPreference = 'Stop'
$toolsDir              = Split-Path -Parent $MyInvocation.MyCommand.Definition
$version               = '1.2.5'
$checksumEn            = '61672F0BD566B1EABD015C3157AAEAEFF541ADE2D74E3C8C854CCD3CED505AC0'
$checksumJp            = 'DB45862524E645E4AFAA876D9C47A2C28AF1F070449F3917D8FF1585A6788E4A'
$ahkFile               = "$toolsDir\install.ahk"
$installDir            = "$env:SystemDrive\PaintToolSAI"

. "$toolsDir\utils.ps1"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = "https://www.systemax.jp/bin/sai-$version-ful-en.exe"
  softwareName  = 'Paint Tool SAI*'
  checksum      = $checksumEn
  checksumType  = 'sha256'
  validExitCodes= @(0)
}

$additionalArgs = Get-PackageParameters
if($additionalArgs['InstallDir']) {
  $installDir = $additionalArgs['InstallDir']

  Set-AhkVariableValue `
    -FileName $ahkFile `
    -Variable 'installDir' `
    -NewValue $installDir `
    -Escape
}

if($additionalArgs['DesktopIcon'] -eq 'yes') {
  Set-AhkVariableValue `
    -FileName $ahkFile `
    -Variable 'desktopIcon' `
    -NewValue 'True' `
}

if($additionalArgs['AssocSai'] -eq 'no') {
  Set-AhkVariableValue `
    -FileName $ahkFile `
    -Variable 'saiAssoc' `
    -NewValue 'False' `
}

$ahkProcess = Start-Process `
                -FilePath 'AutoHotKey' `
                -ArgumentList "`"$ahkFile`"" `
                -PassThru

Install-ChocolateyPackage @packageArgs

Stop-Process $ahkProcess -Force

if($additionalArgs['Language'] -eq 'japanese') {
  Write-Host 'Setting language to Japanese now, please wait!' 

  $packageArgsJp = @{
    packageName   = $env:ChocolateyPackageName
    fileType      = 'EXE'
    url           = "https://www.systemax.jp/bin/sai-$version-ful-ja.exe"
    unzipLocation = "$toolsDir\tmp"
    checksum      = $checksumJp
    checksumType  = 'sha256'
    validExitCodes= @(0)
  }

  Install-ChocolateyZipPackage @packageArgsJp

  Move-Item `
    -Path "$toolsDir\tmp\_language_ja.conf" `
    -Destination "$installDir\language.conf" `
    -Force

  Remove-Item `
    -Path "$toolsDir\tmp" `
    -Recurse -Force `
    -ErrorAction SilentlyContinue
}
