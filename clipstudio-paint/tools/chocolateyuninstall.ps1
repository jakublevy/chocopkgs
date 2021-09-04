$ErrorActionPreference = 'Stop'
$toolsDir              = Split-Path -Parent $MyInvocation.MyCommand.Definition
$defaultSilentArgs     = "/runfromtemp /l0x0409 /uninst /f2`"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).InstallShield.uninstall.log`" /s /f1"

. "$toolsDir\utils.ps1"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  softwareName  = 'Clip Studio Paint*'
  validExitCodes= @(0)
}

$keysToDelete = [System.Collections.ArrayList]@()
[array]$keys = Get-UninstallRegistryKey -SoftwareName 'Clip Studio*'
if($keys.Count -eq 3) { #'Clip Studio Modeler' is installed, keeping 'Clip Studio'
  $keys | ? { $_.DisplayName -match 'Clip Studio Paint*' } | % { $keysToDelete.Add($_) }
}
elseif($keys.Count -le 2 -and $keys.Count -ge 1) { #Removing 'Clip Studio Paint' and 'Clip Studio'. ('Clip Studio Modeler' is not installed)
  $keysToDelete.AddRange($keys)
}
elseif($keys.Count -eq 0) {
  Write-Warning "$($packageArgs['packageName']) has already been uninstalled by other means."
}
else {
  Write-Warning "$($keys.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $keys | % {Write-Warning "- $($_.DisplayName)"}
}

foreach($key in $keysToDelete) {
  $packageArgs['file'] = $key.UninstallString.Substring(1, $key.UninstallString.LastIndexOf('"') - 1)
  $packageArgs['silentArgs'] = $defaultSilentArgs

  if($key.DisplayName -match 'Paint') {
    $packageArgs['silentArgs'] += "`"$toolsDir\uninstallPaint.iss`""
  }
  else {
    $packageArgs['silentArgs'] += "`"$toolsDir\uninstall.iss`""
  }
  Uninstall-ChocolateyPackage @packageArgs
}

#Forgotten quick launch icons
$quickLaunchFolder = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\CLIP STUDIO"
if($keys.Count -eq 3) {
  Remove-Item `
    -Path "$quickLaunchFolder\CLIP STUDIO PAINT.lnk" `
    -Force `
    -ErrorAction SilentlyContinue
}
elseif($keys.Count -le 2) {
  Remove-Item -Path $quickLaunchFolder `
              -Recurse -Force `
              -ErrorAction SilentlyContinue

  #Forgotten desktop shortcuts
  $desktopIcons = @('CLIP STUDIO.lnk', 'CLIP STUDIO PAINT.lnk')
  $desktopIcons | % { Remove-DesktopIcon -ShortcutName $_ }
}
