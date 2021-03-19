$ErrorActionPreference = 'Stop';
$version               = '2.0.0'
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  zipFileName   = "winfetch-$version"
  softwareName  = 'winfetch*'
}

Remove-Item "$env:ChocolateyInstall\bin\winfetch.bat" -Force
Uninstall-ChocolateyZipPackage @packageArgs
