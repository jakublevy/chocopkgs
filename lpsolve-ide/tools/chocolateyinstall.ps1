$ErrorActionPreference = 'Stop';
$toolsDir   = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'EXE'
  file           = Join-Path $toolsDir 'lp_solve_5.5.2.11_IDE_Setup.exe'
  softwareName   = 'LPSolve IDE*'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
}

$addionalArgs = Get-PackageParameters

if($addionalArgs['DIR']) {
  $path = $addionalArgs['DIR']
  $packageArgs['silentArgs'] += " /DIR=""$path"""
}

if($addionalArgs['Tasks']) {
  $packageArgs['silentArgs'] += " /MERGETASKS=`"$($addionalArgs['Tasks'])`""
}

Install-ChocolateyInstallPackage @packageArgs

& "$toolsDir\chocolateybeforemodify.ps1"

Remove-Item `
  -Path $packageArgs['file'] `
  -ErrorAction SilentlyContinue `
  -Force