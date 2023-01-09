$ErrorActionPreference = 'Stop'
$installDir            = "$env:ProgramFiles\Anki"
$version               = '2.1.56'
$checksumQt5           = '727FE3613A9708D4D24ABB1E13FC207D83CC2DDE553786287CEB16CE1B98EBE6'
$checksumQt6           = '3D4D6B83998CC5FF09435FB7E1BD105A0AE749423B1655BBDDB2F557F689A961'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = "https://github.com/ankitects/anki/releases/download/$version/anki-$version-windows-qt6.exe"
  checksum      = $checksumQt6
  checksumType  = 'sha256'
  softwareName  = 'Anki*'
  silentArgs    = "/S"
  validExitCodes= @(0)
}

$additionalArgs = Get-PackageParameters

if($additionalArgs['Qt5']) {
  $packageArgs['url'] = "https://github.com/ankitects/anki/releases/download/$version/anki-$version-windows-qt5.exe"
  $packageArgs['checksum'] = $checksumQt5
}

if($additionalArgs['InstallDir']) {
  $installDir = $additionalArgs['InstallDir']
  $packageArgs['silentArgs'] += " /D=$installDir"
}

Install-ChocolateyPackage @packageArgs

if(!$additionalArgs['CreateDesktopIcon']) {
  Remove-Item `
    -Path "$env:Public\Desktop\Anki.lnk" `
    -Force `
    -ErrorAction SilentlyContinue
}

# Fix bugged start menu icon
Remove-Item `
  -Path "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Anki.lnk" `
  -Force `
  -ErrorAction SilentlyContinue

Install-ChocolateyShortcut `
  -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Anki.lnk" `
  -TargetPath "$installDir\anki.exe" `
  -WorkingDirectory $installDir
