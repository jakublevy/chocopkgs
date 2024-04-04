$ErrorActionPreference = 'Stop'
$installDir            = "$env:localappdata\Programs\Anki"
$version               = '24.04'
$checksumQt5           = '3B4477AEDDACC9A8B481928C188A8577BFA482F537872A2920F37B10C381A17B'
$checksumQt6           = '5B5DB854523C08B4E228E6E01D2CDB12C886403619E290E1B455A29A00689EEE'

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
