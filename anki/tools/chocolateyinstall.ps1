$ErrorActionPreference = 'Stop'
$toolsDir              = Split-Path -parent $MyInvocation.MyCommand.Definition
$installDir            = "$env:ProgramFiles\Anki"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  file          = Join-Path $toolsDir 'anki-2.1.49-windows.exe'
  softwareName  = 'Anki*'
  silentArgs    = "/S"
  validExitCodes= @(0)
}

$additionalArgs = Get-PackageParameters
if($additionalArgs['InstallDir']) {
  $installDir = $additionalArgs['InstallDir']
  $packageArgs['silentArgs'] += " /D=$installDir"
}

Install-ChocolateyPackage @packageArgs

Remove-Item `
  -Path $packageArgs['file'] `
  -ErrorAction SilentlyContinue `
  -Force

if(!$additionalArgs['CreateDesktopIcon']) {
  Remove-Item `
    -Path "$env:Public\Desktop\Anki.lnk" `
    -Force `
    -ErrorAction SilentlyContinue
}

# Fix bugged start menu icon
Remove-Item `
  -Path "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Anki.lnk" `
  -Force `
  -ErrorAction SilentlyContinue

Install-ChocolateyShortcut `
  -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Anki.lnk" `
  -TargetPath "$installDir\anki.exe" `
  -WorkingDirectory $installDir