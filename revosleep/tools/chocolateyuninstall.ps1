$ErrorActionPreference = 'Stop';
$executableName = 'revoSleep'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = "$env:ChocolateyPackageName*"
  fileType      = 'MSI'
  silentArgs    = "/qn /norestart"
  validExitCodes= @(0, 3010, 1605, 1614, 1641)
}

[array]$keys = Get-UninstallRegistryKey -SoftwareName $packageArgs['softwareName']
if ($keys.Count -eq 1) {
  $installLocation = Get-AppInstallLocation $packageArgs['softwareName']
  Uninstall-BinFile `
    -Name $executableName `
    -Path "$installLocation\$executableName.exe"

  $packageArgs['silentArgs'] = "$($keys[0].PSChildName) $($packageArgs['silentArgs'])"
  Uninstall-ChocolateyPackage @packageArgs
} elseif ($keys.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
} elseif ($keys.Count -gt 1) {
  Write-Warning "$($keys.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $keys | % {Write-Warning "- $($_.DisplayName)"}
}
