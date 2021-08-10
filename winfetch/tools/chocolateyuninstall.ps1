$ErrorActionPreference = 'Stop';
$removeNames = @('winfetch.ps1', 'winfetch.bat', 'winfetch.ps1.istext')

$removeNames | % { Remove-Item -Path "$env:ChocolateyInstall\bin\$_" -Force }
