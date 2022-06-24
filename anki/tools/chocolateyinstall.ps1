$ErrorActionPreference = 'Stop'
$installDir            = "$env:ProgramFiles\Anki"
$version               = '2.1.54'
$checksumQt5           = 'f42ad7a5d8135e184350dcc7373f54f326a42960a65072424d39cca04bd702e4'
$checksumQt6           = 'f42ad7a5d8135e184350dcc7373f54f326a42960a65072424d39cca04bd702e4'

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
