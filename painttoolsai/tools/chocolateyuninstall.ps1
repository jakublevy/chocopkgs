$ErrorActionPreference = 'Stop'
$toolsDir              = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ahkFile               = "$toolsDir\uninstall.ahk"
$installDir            = Get-AppInstallLocation 'PaintTool SAI*'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  softwareName  = 'PaintTool SAI*'
  validExitCodes= @(0)
}

[array]$key = Get-UninstallRegistryKey -SoftwareName $packageArgs['softwareName']
if ($key.Count -eq 1) {
  $key | % { 
    $packageArgs['file'] = $key.UninstallString

    $ahkProcess = Start-Process `
                  -FilePath 'AutoHotKey' `
                  -ArgumentList "`"$ahkFile`"" `
                  -PassThru

    Uninstall-ChocolateyPackage @packageArgs

    Stop-Process $ahkProcess -Force

    #Installer removes registry entries, but does not remove app files
    Remove-Item `
      -Path $installDir `
      -Force -Recurse
  }
} elseif ($key.Count -eq 0) {
  Write-Warning "$($packageArgs['packageName']) has already been uninstalled by other means."
} elseif ($key.Count -gt 1) {
  Write-Warning "$($key.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $key | % {Write-Warning "- $($_.DisplayName)"}
}
