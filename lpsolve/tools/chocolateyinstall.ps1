$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileFullPath  = Join-Path $toolsDir 'lp_solve_5.5.2.11_exe_win32.zip'
  fileFullPath64= Join-Path $toolsDir 'lp_solve_5.5.2.11_exe_win64.zip'
  destination   = "$toolsDir\bin"
  validExitCodes= @(0)
}

Get-ChocolateyUnzip @packageArgs

Remove-Item `
  -Path $packageArgs['fileFullPath'], $packageArgs['fileFullPath64'] `
  -ErrorAction SilentlyContinue `
  -Force
