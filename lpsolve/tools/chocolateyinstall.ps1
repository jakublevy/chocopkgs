$ErrorActionPreference = 'Stop';
$toolsDir = $(Split-Path -Parent $MyInvocation.MyCommand.Definition)

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileFullPath  = Join-Path $toolsDir 'lp_solve_5.5.2.11_exe_win32.zip'
  fileFullPath64= Join-Path $toolsDir 'lp_solve_5.5.2.11_exe_win64.zip'
  destination   = "$toolsDir\bin"
  validExitCodes= @(0)
}

Get-ChocolateyUnzip @packageArgs

$filesToRemove = @($packageArgs['fileFullPath'], $packageArgs['fileFullPath64'])
$filesToRemove | % { Remove-Item -Path $_ -ErrorAction SilentlyContinue -Force }
