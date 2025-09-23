$ErrorActionPreference = 'Stop'
$installDir            = "$env:localappdata\Programs\Anki"
$version               = '25.09'
$checksum              = '398F690A8208BD381DC2D4220720A82F6D2249C1FD1B38F46A90DB356CB7C69E'
$toolsDir              = Split-Path -parent $MyInvocation.MyCommand.Definition
$ahkFile               = "$toolsDir\install.ahk"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = "https://github.com/ankitects/anki/releases/download/$version/anki-launcher-$version-windows.exe"
  checksum      = $checksum
  checksumType  = 'sha256'
  softwareName  = 'Anki*'
  silentArgs    = ""
  validExitCodes= @(0,2)
}

$additionalArgs = Get-PackageParameters

if($additionalArgs['InstallDir']) {
  $installDir = $additionalArgs['InstallDir']
  $packageArgs['silentArgs'] += " /D=$installDir"
}

$ahkProcess = Start-Process `
                -FilePath 'AutoHotKey' `
                -ArgumentList "`"$ahkFile`"" `
                -PassThru

Install-ChocolateyPackage @packageArgs

Stop-Process $ahkProcess -Force

if(!$additionalArgs['CreateDesktopIcon']) {
  Remove-Item `
    -Path "$env:Public\Desktop\Anki.lnk" `
    -Force `
    -ErrorAction SilentlyContinue
}
