$ErrorActionPreference = 'Stop';
$absUrl   = 'https://sysprogs.com/getfile/986/Analyzer2Go-2.2-trial.msi'
$checksum = 'FD3CF65A5F18A34A8581CBCD8E083A71DF95625D83A5AE80677897D69AF2C794'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'MSI'
  url           = $absUrl
  softwareName  = "$env:ChocolateyPackageName*"
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
