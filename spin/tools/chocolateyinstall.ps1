$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath64 = Join-Path $toolsDir 'pc_spin651.zip'
  destination    = "$toolsDir\bin"
  validExitCodes = @(0)
}

Get-ChocolateyUnzip @packageArgs

Remove-Item `
  -Path $packageArgs['fileFullPath64'] `
  -ErrorAction SilentlyContinue `
  -Force

$shortcutArgs = @{
  targetPath  = "$toolsDir\bin\ispin.tcl"
}

$additionalArgs = Get-PackageParameters
if($additionalArgs['CreateiSpinDesktopIcon']) {
  Install-ChocolateyShortcut `
    -ShortcutFilePath "$env:userprofile\Desktop\iSpin.lnk" `
    @shortcutArgs
}

if($additionalArgs['AddiSpinToStartMenu'] -eq "allusers") {
  Install-ChocolateyShortcut `
    -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\iSpin.lnk" `
    @shortcutArgs
}
elseif($additionalArgs['AddiSpinToStartMenu'] -eq "curruser") {
  Install-ChocolateyShortcut `
    -ShortcutFilePath "$env:AppData\Microsoft\Windows\Start Menu\Programs\iSpin.lnk" `
    @shortcutArgs
}