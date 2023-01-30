$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'EXE'
  file           = Join-Path $toolsDir 'mnemosyne-2.10-setup.exe'
  softwareName   = "$env:ChocolateyPackageName*"
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
}

$additionalArgs = Get-PackageParameters

if($additionalArgs['InstallDir']) {
  $path = $additionalArgs['InstallDir']
  $packageArgs['silentArgs'] += " /DIR=""$path"""
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item `
  -Path $packageArgs['file'] `
  -ErrorAction SilentlyContinue `
  -Force
