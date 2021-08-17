$ErrorActionPreference = 'Stop';
$toolsDir = $(Split-Path -Parent $MyInvocation.MyCommand.Definition)

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileFullPath64= Join-Path $toolsDir 'pdfcrack-v0.19-windows-amd64.zip'
  destination   = "$toolsDir\bin"
  validExitCodes= @(0)
}

Get-ChocolateyUnzip @packageArgs
