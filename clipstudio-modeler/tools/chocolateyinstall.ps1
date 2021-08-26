$ErrorActionPreference = 'Stop'
$toolsDir              = $(Split-Path -Parent $MyInvocation.MyCommand.Definition)
$version               = '11013'
$checksum64            = 'B8A9AEF757FC16010B11B187686628ECA64035DB08C41CD18F55EF64E8305517'
$issFile               = "$toolsDir\install.iss"
$languageFilesRoot     = "$env:ProgramData\CELSYS\CLIPStudio\InstallPath"
$languageFiles         = @("$languageFilesRoot\modeler15.txt", "$languageFilesRoot\clipstudio15.txt")
$installDir            = "$env:ProgramFiles\CELSYS"
$modelerBinaryRelative = "CLIP STUDIO 1.5\CLIP STUDIO MODELER\CLIPStudioModeler.exe"
$clipBinaryRelative    = "CLIP STUDIO 1.5\CLIP STUDIO\CLIPStudio.exe"

. "$toolsDir\utils.ps1"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url64         = "https://vd.clipstudio.net/clipcontent/modeler/app/$version/CSM_$($version)w_setup.exe"
  softwareName  = "Clip Studio Modeler*"
  checksum      = $checksum64
  checksumType  = 'sha256'
  silentArgs    = "/l0x0409 /f2`"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).InstallShield.install.log`" /s /f1`"$issFile`"" #skips everything except eula, GUI still visible
  validExitCodes= @(0)
}

$additionalArgs = Get-PackageParameters
if($additionalArgs['InstallDir']) {
  $installDir = $additionalArgs['InstallDir']

  Set-FileLine `
    -FileName $issFile `
    -LinePart "szDir" `
    -NewContent "szDir=$installDir"
}

Install-ChocolateyPackage @packageArgs

if($null -eq $additionalArgs['Language']) {
  $additionalArgs['Language'] = 'english'
}
$additionalArgs['Language'] = $additionalArgs['Language'].ToLower()

foreach($lf in $languageFiles) {
  Set-FileLine `
    -FileName $lf `
    -LinePart '"Language"' `
    -NewContent "`"Language`"=`"$($additionalArgs['Language'])`";"
}
Write-Host "Language set to $($additionalArgs['Language'])"

Install-ChocolateyShortcut `
  -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\CLIP STUDIO\CLIP STUDIO MODELER.lnk" `
  -TargetPath "$installDir\$modelerBinaryRelative"

#Remove auto-created shortcut in Public\Desktop
Remove-Item `
  -Path "$env:Public\Desktop\CLIP STUDIO.lnk" `
  -Force `
  -ErrorAction SilentlyContinue

if($additionalArgs['desktopicon'] -eq 'yes') {
  New-DesktopIcon `
    -ShortcutName 'CLIP STUDIO MODELER.lnk' `
    -TargetPath "$installDir\$modelerBinaryRelative"

  New-DesktopIcon `
    -ShortcutName 'CLIP STUDIO.lnk' `
    -TargetPath "$installDir\$clipBinaryRelative"

  Write-Host 'Desktop icons created'
}