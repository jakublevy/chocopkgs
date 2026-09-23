$ErrorActionPreference = 'Stop'
$installDir            = "$env:localappdata\Programs\Anki"
$version               = '26.09.3'
$checksum              = '8A45823D1C31017CEBB7D3AF4493D69B6AE3C185345FCB2390EDE4AF01E0A950'
$toolsDir              = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'MSI'
  url           = "https://github.com/ankitects/anki/releases/download/$version/anki-$version-win-x64.msi"
  checksum      = $checksum
  checksumType  = 'sha256'
  softwareName  = 'Anki*'
  silentArgs    = "ALLUSERS=1 /qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)
}

$additionalArgs = Get-PackageParameters
if($additionalArgs['InstallDir']) {
  $packageArgs['silentArgs'] += " INSTALLFOLDER=`"$($additionalArgs['InstallDir'])`""
}

Install-ChocolateyPackage @packageArgs

if(!$additionalArgs['CreateDesktopIcon']) {
  Remove-Item `
    -Path "$env:Public\Desktop\Anki.lnk" `
    -Force `
    -ErrorAction SilentlyContinue
}
