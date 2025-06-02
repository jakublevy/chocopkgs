$ErrorActionPreference = 'Stop'
$installDir            = "$env:localappdata\Programs\Anki"
$version               = '25.02.6'
$checksum              = '1532223833B45D52DA30ED315F3BA275D9CAD6C67842A0E54FBF394DFDB8BFB6'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url           = "https://github.com/ankitects/anki/releases/download/$version/anki-$version-windows-qt6.exe"
  checksum      = $checksum
  checksumType  = 'sha256'
  softwareName  = 'Anki*'
  silentArgs    = "/S"
  validExitCodes= @(0)
}

$additionalArgs = Get-PackageParameters

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
