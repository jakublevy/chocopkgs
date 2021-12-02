$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
Get-ChildItem "$toolsDir\bin\*.cmd" | % {
    Uninstall-BinFile `
      -Name $_.BaseName `
      -Path $_.FullName
  }