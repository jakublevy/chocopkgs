$ErrorActionPreference = 'Stop'
$toolsDir              = Split-Path -Parent $MyInvocation.MyCommand.Definition
$version               = '11013'
$checksum64            = 'A9DFA795D92185F9C29E3087AE8A7E606804396AF4DAAA0A6619FD3A61257FCC'
$issFile               = "$toolsDir\install.iss"
$ahkFile               = "$toolsDir\install.ahk"
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

$ahkProcess = Start-Process `
                -FilePath 'AutoHotKey' `
                -ArgumentList "`"$ahkFile`"" `
                -PassThru

Write-Host 'The installer GUI might appear, dissapear and freeze. It is still installing. Please be patient!' -ForegroundColor Cyan
Install-ChocolateyPackage @packageArgs

Stop-Process $ahkProcess -Force

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