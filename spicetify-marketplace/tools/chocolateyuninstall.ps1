$ErrorActionPreference = 'Stop'
$toolsDir              = Split-Path -parent $MyInvocation.MyCommand.Definition
$customAppsDir         = "$env:userprofile\.spicetify\CustomApps"

. "$toolsDir\utils.ps1"

$spotify = Get-Process -Name 'spotify' -ErrorAction SilentlyContinue

Remove-Item `
  -Path "$customAppsDir\spicetify-marketplace" `
  -ErrorAction SilentlyContinue `
  -Force -Recurse

Update-SpicetifyConfig `
  -FileName "$env:userprofile\.spicetify\config-xpui.ini" `
  -LinePart 'custom_apps' `
  -ReplacePart 'spicetify-marketplace' `
  -ReplaceBy ''

Start-Process `
  -FilePath 'spicetify' `
  -ArgumentList 'apply' `
  -NoNewWindow

if(-not $spotify) {
  $sw = [System.Diagnostics.Stopwatch]::StartNew()
  while($sw.ElapsedMilliseconds -lt 10000) {
    $spotify = Get-Process 'spotify' -ErrorAction SilentlyContinue
    if($spotify) {
      Stop-Process $spotify -Force
      break
    }
  }
}