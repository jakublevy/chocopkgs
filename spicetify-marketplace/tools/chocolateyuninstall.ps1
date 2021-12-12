$ErrorActionPreference = 'Stop'
$customAppsDir         = "$env:userprofile\.spicetify\CustomApps"

$spotifyInstalled = $true
$spotify = Get-Process -Name 'spotify' -ErrorAction SilentlyContinue
if(-not $spotify) {
  $spotifyInstalled = $null -ne (Get-AppInstallLocation 'spotify')
}

Remove-Item `
  -Path "$customAppsDir\spicetify-marketplace" `
  -ErrorAction SilentlyContinue `
  -Force -Recurse

spicetify config custom_apps spicetify-marketplace-

Start-Process `
  -FilePath 'spicetify' `
  -ArgumentList 'apply' `
  -NoNewWindow

if(-not $spotify -And $spotifyInstalled) {
  $sw = [System.Diagnostics.Stopwatch]::StartNew()
  while($sw.ElapsedMilliseconds -lt 5000) {
    $spotify = Get-Process 'spotify' -ErrorAction SilentlyContinue
    if($spotify) {
      Stop-Process $spotify -Force
      break
    }
  }
}