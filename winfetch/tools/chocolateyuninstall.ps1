$ErrorActionPreference = 'Stop';
$version               = '2.0.0'
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  zipFileName   = "winfetch-$version"
  softwareName  = 'winfetch*'
}

Uninstall-BinFile `
  -Name 'winfetch' `
  -Path "$env:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe"

Uninstall-ChocolateyZipPackage @packageArgs
