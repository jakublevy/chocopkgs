$ErrorActionPreference = 'Stop'
$installDir            = "$env:localappdata\Programs\Anki"
$version               = '26.08.1'
$checksum              = 'D79170C3CD2E6225F9C2BA33212117A8FE70C10735C3F0E5A2864E2F0CCF7C8C'
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
