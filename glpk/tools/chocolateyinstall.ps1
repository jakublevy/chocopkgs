$ErrorActionPreference = 'Stop';
$toolsDir = $(Split-Path -Parent $MyInvocation.MyCommand.Definition)
$version  = '4.65'
$checksum = 'A8C195B92682C3AC1F6DAE5F6CE2472C2478835F9873BE4A0C6771C37DB53C2D'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  url           = "https://sourceforge.net/projects/winglpk/files/winglpk/GLPK-$version/winglpk-$version.zip"
  checksum      = $checksum
  checksumType  = 'sha256'
  unzipLocation = "$toolsDir"
  validExitCodes= @(0)
}

Install-ChocolateyZipPackage @packageArgs

$installedDir = "$($packageArgs['unzipLocation'])\glpk-$version"
$parentKeepList = @("w$(Get-OSArchitectureWidth)", 'doc', 'examples', 'NEWS', 'README', 'README.md', 'THANKS', 'COPYING', 'INSTALL', 'AUTHORS', 'ChangeLog')
Write-Output 'Removing unnecessary compilation left-overs.'
Get-ChildItem $installedDir | ? { $parentKeepList -notcontains $_.Name } | Remove-Item -Recurse -Force
Get-ChildItem "$installedDir\doc" -Exclude '*.pdf', '*.txt' , 'cli', 'notes' | Remove-Item -Force
Get-ChildItem "$installedDir\$($parentKeepList[0])" -Exclude '*.jar', '*.exe', '*.txt', '*.dll' | Remove-Item -Force
