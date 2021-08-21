$ErrorActionPreference = 'Stop';

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'Wacom Tablet*'
  fileType      = 'EXE'
  silentArgs    = '/u /S'
  validExitCodes= @(0, 1, 2)
  # 0 uninstalled (nothing more, nothing less)
  # 1 uninstalled, but reboot is required now (prior uninstallation no pending reboot)
  # 2 uninstalled, but there was already a pending reboot prior to uninstallation
}

[array]$key = Get-UninstallRegistryKey -SoftwareName $packageArgs['softwareName']
if ($key.Count -eq 1) {
  $key | % { 
    $packageArgs['file'] = $key.DisplayIcon
    Uninstall-ChocolateyPackage @packageArgs
  }
} elseif ($key.Count -eq 0) {
  Write-Warning "$($packageArgs['packageName']) has already been uninstalled by other means."
} elseif ($key.Count -gt 1) {
  Write-Warning "$($key.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $key | % {Write-Warning "- $($_.DisplayName)"}
}
