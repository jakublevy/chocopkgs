$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileFullPath  = Join-Path $toolsDir 'winglpk-4.65.zip'
  destination   = $toolsDir
  validExitCodes= @(0)
}

Get-ChocolateyUnzip @packageArgs

Remove-Item `
  -Path $packageArgs['fileFullPath'] `
  -ErrorAction SilentlyContinue `
  -Force

$bits = '64'
if((Get-OSArchitectureWidth -Compare 32) -or $env:ChocolateyForceX86) {
  $bits = '32'
}

$installedDir = (Get-ChildItem "$($packageArgs['destination'])\glpk*")[0].FullName
$parentKeepList = @("w$bits", 'doc', 'examples', 'NEWS', 'README', 'README.md', 'THANKS', 'COPYING', 'INSTALL', 'AUTHORS', 'ChangeLog')
Write-Output 'Removing unnecessary compilation left-overs.'
Get-ChildItem $installedDir | ? { $parentKeepList -notcontains $_.Name } | Remove-Item -Recurse -Force
Get-ChildItem "$installedDir\doc" -Exclude '*.pdf', '*.txt' , 'cli', 'notes' | Remove-Item -Force
Get-ChildItem "$installedDir\$($parentKeepList[0])" -Exclude '*.jar', '*.exe', '*.txt', '*.dll' | Remove-Item -Force
