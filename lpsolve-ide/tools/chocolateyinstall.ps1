$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'EXE'
  file           = Join-Path $toolsDir 'lp_solve_5.5.2.11_IDE_Setup.exe'
  softwareName   = 'LPSolve IDE*'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
}

$additionalArgs = Get-PackageParameters

if($additionalArgs['DIR']) {
  $path = $additionalArgs['DIR']
  $packageArgs['silentArgs'] += " /DIR=""$path"""
}

if($additionalArgs['Tasks']) {
  $packageArgs['silentArgs'] += " /MERGETASKS=`"$($additionalArgs['Tasks'])`""
}

Install-ChocolateyInstallPackage @packageArgs

& "$toolsDir\chocolateybeforemodify.ps1"

Remove-Item `
  -Path $packageArgs['file'] `
  -ErrorAction SilentlyContinue `
  -Force