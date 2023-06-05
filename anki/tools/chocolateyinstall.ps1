$ErrorActionPreference = 'Stop'
$installDir            = "$env:localappdata\Programs\Anki"
$version               = '2.1.65'
$checksumQt5           = '0FECC6C5E51174431E209377F4EAED6A52CD2648FDAFB3E79E6F6EB6CD3F461A'
$checksumQt6           = '02D992A47FE826254B3DC707226D9D06C006F3FA0DC1E66C9E47767316896ED9'

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
