$ErrorActionPreference = 'Stop'
$toolsDir              = Split-Path -parent $MyInvocation.MyCommand.Definition
$ahkFile               = "$toolsDir\uninstall.ahk"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'Anki*'
  fileType      = 'EXE'
  silentArgs    = '/S'
  validExitCodes= @(0)
}

. "$toolsDir\utils.ps1"

$additionalArgs = Get-PackageParameters

if($additionalArgs['RemoveProfiles']) {
    Set-AhkVariableValue `
    -FileName $ahkFile `
    -Variable 'removeProfiles' `
    -NewValue 'y' `
    -Escape
}

[array]$keys = Get-UninstallRegistryKey -SoftwareName $packageArgs['softwareName']
if ($keys.Count -eq 1) {
    $packageArgs['file'] = $keys[0].UninstallString

    Uninstall-ChocolateyPackage @packageArgs

    $ahkProcess = Start-Process `
                    -FilePath 'AutoHotKey' `
                    -ArgumentList "`"$ahkFile`""

    while($true) {
        [array]$keys = Get-UninstallRegistryKey -SoftwareName $packageArgs['softwareName']
        if($keys.Count -eq 0) {
            break;
        }
        Start-Sleep -Milliseconds 100
    }

} elseif ($keys.Count -eq 0) {
  Write-Warning "$($packageArgs['packageName']) has already been uninstalled by other means."
} elseif ($keys.Count -gt 1) {
  Write-Warning "$($keys.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $keys | % {Write-Warning "- $($_.DisplayName)"}
}