$ErrorActionPreference = 'Stop'
$installDir            = "$env:ProgramFiles\Anki"
$version               = '2.1.63'
$checksumQt5           = 'D2C28563EC07312710FC1B758E24E0A342CEFE99FDE65A1B37DF6D5E975CEC63'
$checksumQt6           = '8BED2F94E2F769DDF01CC4937FA981F7B41806C20F7171B5D38C9AD0084ADB93'

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
