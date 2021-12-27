$ErrorActionPreference = 'Stop'
$installDir            = "$env:ProgramFiles\Anki"
$checksum              = '3c9764cb4746cfa4059633678b9dcdc0ae5754e61d99855cb0c40fa6bfd33f5e'
$version               = '2.1.49'
$silentArgs            = '/S'

$additionalArgs = Get-PackageParameters
if($additionalArgs['InstallDir']) {
  $installDir = $additionalArgs['InstallDir']
  $silentArgs += " /D=$installDir"
}

Install-ChocolateyPackage `
	-PackageName 'anki' `
	-FileType 'exe' `
	-SilentArgs $silentArgs  `
	-Url "https://github.com/ankitects/anki/releases/download/$version/anki-$version-windows.exe" `
	-Checksum $checksum `
	-ChecksumType 'sha256'

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
