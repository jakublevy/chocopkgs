$ErrorActionPreference = 'Stop'
$toolsDir              = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ahkFile               = "$toolsDir\uninstall.ahk"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'Memento*'
  fileType      = 'EXE'
  silentArgs    = '/S' # One dialog still appears
  validExitCodes= @(0)
}

[array]$keys = Get-UninstallRegistryKey -SoftwareName $packageArgs['softwareName']
if ($keys.Count -eq 1) {
  $packageArgs['file'] = $keys[0].UninstallString
  
  $ahkProcess = Start-Process `
                  -FilePath 'AutoHotKey' `
                  -ArgumentList "`"$ahkFile`"" `
                  -PassThru

    Uninstall-ChocolateyPackage @packageArgs

    Stop-Process $ahkProcess -Force

} elseif ($keys.Count -eq 0) {
  Write-Warning "$($packageArgs['packageName']) has already been uninstalled by other means."
} elseif ($keys.Count -gt 1) {
  Write-Warning "$($keys.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $keys | % {Write-Warning "- $($_.DisplayName)"}
}
