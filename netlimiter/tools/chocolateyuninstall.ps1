$ErrorActionPreference = 'Stop';
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = "$env:ChocolateyPackageName*"
  fileType      = 'MSI'
  silentArgs    = "/qn /norestart"
  validExitCodes= @(0, 3010, 1605, 1614, 1641)
}

$additionalArgs = Get-PackageParameters
if($additionalArgs['CleanSettings']) {
  $packageArgs['silentArgs'] += " NL_CLEAN_SETTINGS=1"
}

[array]$keys = Get-UninstallRegistryKey -SoftwareName $packageArgs['softwareName']
if ($keys.Count -eq 2) {
  $keys | ? WindowsInstaller | % {
    $packageArgs['silentArgs'] = "$($_.PSChildName) $($packageArgs['silentArgs'])"
    Uninstall-ChocolateyPackage @packageArgs
  }
} elseif ($keys.Count -eq 1) {
  Write-Warning "$($packageArgs['packageName']) is partially uninstalled!"
  Write-Warning "Removing leftovers."
  if ($keys[0].WindowsInstaller) {
    $packageArgs['silentArgs'] = "$($keys[0].PSChildName) $($packageArgs['silentArgs'])"
  } else {
    $key = [regex]::match($keys[0].DisplayIcon, '.+\\.+\\.+\\(.+)\\.+').Groups[1].Value
    $packageArgs['silentArgs'] = "$key $($packageArgs['silentArgs'])"
  }
  Uninstall-ChocolateyPackage @packageArgs
} elseif ($keys.Count -eq 0) {
  Write-Warning "$($packageArgs['packageName']) has already been uninstalled by other means."
} elseif ($keys.Count -gt 2) {
  Write-Warning "$($keys.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $keys | % {Write-Warning "- $($_.DisplayName)"}
}
