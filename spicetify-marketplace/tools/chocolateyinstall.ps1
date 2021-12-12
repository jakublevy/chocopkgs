$ErrorActionPreference = 'Stop'
$toolsDir              = Split-Path -parent $MyInvocation.MyCommand.Definition
$customAppsDir         = "$env:userprofile\.spicetify\CustomApps"
$archiveName           = 'spicetify-marketplace-0.3.1-alpha.zip'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileFullPath   = "$toolsDir\$archiveName"
  destination    = $customAppsDir
  validExitCodes = @(0)
}

# Based on official installer: https://github.com/CharlieS1103/spicetify-marketplace/blob/main/install.ps1

$spotify = Get-Process -Name 'spotify' -ErrorAction SilentlyContinue

if (-not (Test-Path $customAppsDir)) {
  Write-Host "Making a CustomApps folder..."
  New-Item -Path $customAppsDir -ItemType Directory | Out-Null
}
elseif(Test-Path "$customAppsDir\spicetify-marketplace") {
  Write-Host 'spicetify-marketplace was already found! Updating...'
  Remove-Item -Path "$customAppsDir\spicetify-marketplace" -Force -Recurse
}

Get-ChocolateyUnzip @packageArgs

Rename-Item `
  -Path "$customAppsDir\$($archiveName.Replace('.zip', ''))" `
  -NewName 'spicetify-marketplace' `
  -Force

Remove-Item `
  -Path $packageArgs['fileFullPath'] `
  -ErrorAction SilentlyContinue `
  -Force

spicetify config custom_apps spicetify-marketplace

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