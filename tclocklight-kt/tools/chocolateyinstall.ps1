﻿$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = Join-Path $toolsDir 'tclocklight-kt240522-x86.zip'
  fileFullPath64 = Join-Path $toolsDir 'tclocklight-kt240522-x64.zip'
  destination    = "$toolsDir\bin"
  validExitCodes = @(0)
}

Get-ChocolateyUnzip @packageArgs

Remove-Item `
  -Path $packageArgs['fileFullPath'], $packageArgs['fileFullPath64'] `
  -ErrorAction SilentlyContinue `
  -Force

$shortcut = 'tclocklight-kt.lnk'
$targetBin = "$toolsDir\bin\tclock.exe"
$additionalArgs = Get-PackageParameters
if($additionalArgs['AddToUserStartup'] -eq 'yes') {
  Install-ChocolateyShortcut `
    -ShortcutFilePath "$env:AppData\Microsoft\Windows\Start Menu\Programs\Startup\$shortcut" `
    -TargetPath $targetBin

  Write-Host 'TClock Light kt is automatically started on this user login.'
}

if($null -eq $additionalArgs['AddToSystemStartup'] -or $additionalArgs['AddToSystemStartup'] -ne 'no') {
  Install-ChocolateyShortcut `
    -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\$shortcut" `
    -TargetPath $targetBin

    Write-Host 'TClock Light kt is automatically started after bootup.'
}

$shimArgs = @{
  path       = $packageArgs['destination']
  itemType   = 'file'
  errorAction= 'SilentlyContinue'
}

$ignoreBinaries = @('tctimer.exe', 'tcsntp.exe', 'tcprop.exe')
$ignoreBinaries | % { New-Item -Name "$_.ignore" @shimArgs }


& $targetBin
Write-Host 'TClock Light kt is now running.'
