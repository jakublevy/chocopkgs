$ErrorActionPreference = 'Stop';

$shortcut = 'tclocklight-kt.lnk'
$existsStartup = $false

$systemStartupPath = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\$shortcut"
$userStartupPath = "$env:AppData\Microsoft\Windows\Start Menu\Programs\Startup\$shortcut"

if(Test-Path -Path $systemStartupPath) {
  $existsStartup = $true
  Remove-Item `
    -Path $systemStartupPath `
    -ErrorAction SilentlyContinue `
    -Force
}
if(Test-Path -Path $userStartupPath) {
  $existsStartup = $true
  Remove-Item `
    -Path $userStartupPath `
    -ErrorAction SilentlyContinue `
    -Force
}

if($existsStartup) {
  Write-Output 'TClock Light automatic start is now removed.'
}