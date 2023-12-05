$ErrorActionPreference = 'Stop'
$toolsDir              = Split-Path -Parent $MyInvocation.MyCommand.Definition
$version               = '230'
$checksum64            = '0be7b45ee245be951ab48138b37f095c44e2a2112af308b2fe2f4a79cf2c9a35'
$issFile               = "$toolsDir\install.iss"
$languageFilesRoot     = "$env:ProgramData\CELSYS\CLIPStudio\InstallPath"
$languageFiles         = @("$languageFilesRoot\paint15.txt", "$languageFilesRoot\clipstudio15.txt")
$installDir            = "$env:ProgramFiles\CELSYS"
$paintBinaryRelative   = "CLIP STUDIO 1.5\CLIP STUDIO PAINT\CLIPStudioPaint.exe"
$clipBinaryRelative    = "CLIP STUDIO 1.5\CLIP STUDIO\CLIPStudio.exe"

. "$toolsDir\utils.ps1"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'EXE'
  url64         = "https://vd.clipstudio.net/clipcontent/paint/app/$version/CSP_$($version)w_setup.exe"
  softwareName  = "Clip Studio Paint*"
  checksum64    = $checksum64
  checksumType  = 'sha256'
  silentArgs    = "/l0x0409 /f2`"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).InstallShield.install.log`" /s /f1`"$issFile`""
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
  -ShortcutFilePath "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\CLIP STUDIO\CLIP STUDIO PAINT.lnk" `
  -TargetPath "$installDir\$paintBinaryRelative"

#Remove auto-created shortcut in Public\Desktop
Remove-Item `
  -Path "$env:Public\Desktop\CLIP STUDIO.lnk" `
  -Force `
  -ErrorAction SilentlyContinue

if($additionalArgs['desktopicon'] -eq 'yes') {
  New-DesktopIcon `
    -ShortcutName 'CLIP STUDIO PAINT.lnk' `
    -TargetPath "$installDir\$paintBinaryRelative"

  New-DesktopIcon `
    -ShortcutName 'CLIP STUDIO.lnk' `
    -TargetPath "$installDir\$clipBinaryRelative"

  Write-Host 'Desktop icons created'
}
