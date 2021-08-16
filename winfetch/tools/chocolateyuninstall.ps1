$ErrorActionPreference = 'Stop';
$removeNames = @('winfetch.ps1', 'winfetch.bat')

$removeNames | % { Remove-Item -Path "$env:ChocolateyInstall\bin\$_" -Force -ErrorAction SilentlyContinue }
