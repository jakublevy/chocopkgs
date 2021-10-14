$ErrorActionPreference = 'Stop'
$toolsDir              = Split-Path -parent $MyInvocation.MyCommand.Definition
$ahkFile               = "$toolsDir\install.ahk"

. "$toolsDir\utils.ps1"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = "zkanji*"
  fileType      = 'EXE'
  file          = Join-Path $toolsDir 'zkanji_0_731_Setup_newdir.exe'
  #silentArgs    = '/S' silent installation for this NSIS installer is bugged
  validExitCodes= @(0, 1223) #exit code always 1223 
}

$additionalArgs = Get-PackageParameters
if($additionalArgs['InstallDir']) {
  Set-AhkVariableValue `
    -FileName $ahkFile `
    -Variable 'installDir' `
    -NewValue $additionalArgs['InstallDir'] `
    -Escape
}
elseif(Get-OSArchitectureWidth -Compare 64) {
  Set-AhkVariableValue `
    -FileName $ahkFile `
    -Variable 'installDir' `
    -NewValue "${env:ProgramFiles(x86)}\zkanji" `
    -Escape
}
else { #32-bit
  Set-AhkVariableValue `
    -FileName $ahkFile `
    -Variable 'installDir' `
    -NewValue "$env:ProgramFiles\zkanji" `
    -Escape
}

if($additionalArgs['CreateDesktopIcon']) {
  Set-AhkVariableValue `
    -FileName $ahkFile `
    -Variable 'desktopIcon' `
    -NewValue "True"
}

$ahkProcess = Start-Process `
                -FilePath 'AutoHotKey' `
                -ArgumentList "`"$ahkFile`"" `
                -PassThru

Install-ChocolateyInstallPackage @packageArgs

Stop-Process $ahkProcess -Force

Remove-Item `
  -Path $packageArgs['file'] `
  -ErrorAction SilentlyContinue `
  -Force