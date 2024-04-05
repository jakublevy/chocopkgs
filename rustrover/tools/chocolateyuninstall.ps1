$ErrorActionPreference = 'Stop'
$toolsDir              = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ahkFile               = "$toolsDir\uninstall.ahk"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'RustRover*'
  fileType      = 'EXE'
  validExitCodes= @(0)
}

$additionalArgs = Get-PackageParameters
if($additionalArgs['DeleteCache']) {
  (Get-Content $ahkFile | % { $_ -replace "deleteCache :=.*", "deleteCache := true" }) | Set-Content $ahkFile
}

if($additionalArgs['DeleteSettings']) {
  (Get-Content $ahkFile | % { $_ -replace "deleteSettings :=.*", "deleteSettings := true" }) | Set-Content $ahkFile
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
  $keys | % { Write-Warning "- $($_.DisplayName)" }
}
