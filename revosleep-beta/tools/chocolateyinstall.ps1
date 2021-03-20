$ErrorActionPreference = 'Stop';
$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$version               = '0.4.0'
$checksum              = '010B45AFB2FCB0CD5ECD1241708F6E5792DFECA6A21160A243EE45217BBC9096'
$checksum64            = 'E79A61803992083808ECC653896581A285A88D18EC63556E0122B83AC3142D94'

# Required – download links contain session id
$page          = Invoke-WebRequest -UseBasicParsing -Uri 'https://www.meinfach.net/revosleep/'
$downloadLinks = $page.Links     | Where-Object href -match $version 
$url           = ($downloadLinks | Where-Object class -match "revoSleepx86" | Select-Object -First 1 -exp href) -Replace ';', '&'
$url64         = ($downloadLinks | Where-Object class -match "revoSleepx64" | Select-Object -First 1 -exp href) -Replace ';', '&'

$extractedFullPath = "$toolsDir\revoSleep_v${version}_BETA (x64)"
if(Get-OSArchitectureWidth -Compare 32) {
  $extractedFullPath = "$toolsDir\revoSleep_v${version}_BETA (x86)"
}

Install-ChocolateyZipPackage `
  -PackageName    $env:ChocolateyPackageName `
  -Url            $url `
  -Url64          $url64 `
  -Checksum       $checksum `
  -ChecksumType   'sha256' `
  -Checksum64     $checksum64 `
  -ChecksumType64 'sha256' `
  -UnzipLocation  $toolsDir


Install-ChocolateyInstallPackage `
  -PackageName $env:ChocolateyPackageName `
  -SoftwareName 'revosleep-beta*' `
  -File "$extractedFullPath\setup.msi" `
  -FileType 'MSI' `
  -SilentArgs "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`"" `
  -ValidExitCodes @(0, 3010, 1641)

Remove-Item $extractedFullPath -Force -Recurse
