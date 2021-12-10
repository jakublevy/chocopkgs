$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$binFileArgs = @{
  name    = 'pdftk'
  command = "`"-jar $toolsDir\pdftk-all.jar`""
}

$additionalArgs = Get-PackageParameters
if($additionalArgs['JavaExePath']) {
  $binFileArgs['path'] = $additionalArgs['JavaExePath']
}
elseif ($null -ne $env:JAVA_HOME) { 
  $binFileArgs['path'] = "$env:JAVA_HOME\bin\java.exe"
}
else {
  $binFileArgs['path'] = 'java.exe'
}

Install-BinFile @binFileArgs