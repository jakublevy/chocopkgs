$ErrorActionPreference = 'Stop'
$toolsDir              = Split-Path -parent $MyInvocation.MyCommand.Definition
$checksum32            = '1CAE914E43B39E47261AAFCB5F6A9C3F317EFE4757046720AB8D8F61D16C6AFA'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  file          = "$toolsDir\Quiet.zip"
  checksum      = $checksum32
  checksumType  = 'sha256'
  unzipLocation = "$toolsDir\bin"
  validExitCodes= @(0)
}

$requestParams = @{
  useBasicParsing = $true
  uri             = 'https://www.joeware.net/downloads/dl2.php'
  method          = 'POST'
  outFile         = "$toolsDir\Quiet.zip"
  body            = @{
    download = 'Quiet.zip'
    B1       = 'Download+Now'
  }
}

Invoke-WebRequest @requestParams

Install-ChocolateyZipPackage @packageArgs

Remove-Item `
  -Path "$toolsDir\Quiet.zip" `
  -ErrorAction SilentlyContinue `
  -Force