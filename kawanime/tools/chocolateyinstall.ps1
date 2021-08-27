$ErrorActionPreference = 'Stop'
$toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  file64        = Join-Path $toolsDir 'KawAnime.Setup.0.4.2.exe'
  softwareName  = "$env:ChocolateyPackageName*"
  silentArgs    = "/S"
  validExitCodes= @(0)
}

$additionalArgs = Get-PackageParameters
if($null -eq $additionalArgs['InstallForAllUsers'] -or $additionalArgs['InstallForAllUsers'] -ne 'no') {
  $packageArgs['silentArgs'] += ' /ALLUSERS'
}

if($additionalArgs['InstallDir']) {
  $packageArgs['silentArgs'] += " /D=$($additionalArgs['InstallDir'])"
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item `
  -Path $packageArgs['file64'] `
  -ErrorAction SilentlyContinue `
  -Force