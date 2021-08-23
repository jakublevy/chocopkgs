$ErrorActionPreference = 'Stop';
$absUrl   = 'https://sysprogs.com/getfile/1526/VisualKernel-3.1r9-trial.msi'
$checksum = '5B7988E4E32E22001539F5799546AABD8C8E805956C2CC8F7D2B9B6BC8D36F71'

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
