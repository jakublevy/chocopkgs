$ErrorActionPreference = 'Stop'
$installDir            = "$env:ProgramFiles\Anki"
$version               = '2.1.62'
$checksumQt5           = '5198C97641C773BDFB420BA92C27EEB12FEF30FB0CDAA90320F870812008CA76'
$checksumQt6           = 'E0A22C418C85AF852962E2AFCA5C7D4720A913115B475B596CF3783919D31FF5'

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
