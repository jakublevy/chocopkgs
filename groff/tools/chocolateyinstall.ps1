$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileFullPath  = Join-Path $toolsDir 'groff-1.22.4-w32-bin.zip'
  destination   = $toolsDir
  validExitCodes= @(0)
}

Get-ChocolateyUnzip @packageArgs

Get-ChildItem "$toolsDir\bin\*.cmd" | % {
  Install-BinFile `
    -Name $_.BaseName `
    -Path $_.FullName
}

Remove-Item `
  -Path $packageArgs['fileFullPath'] `
  -ErrorAction SilentlyContinue `
  -Force