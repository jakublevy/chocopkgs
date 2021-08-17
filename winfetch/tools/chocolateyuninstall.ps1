$ErrorActionPreference = 'Stop';

$binaryLocation = "$(Get-ToolsLocation)\winfetch"

Remove-Item `
    -Path $binaryLocation `
    -Recurse -Force

$machineScope = [EnvironmentVariableTarget]::Machine
$newPath = [Environment]::GetEnvironmentVariable('Path', $machineScope).Replace(";$binaryLocation", '')
[Environment]::SetEnvironmentVariable('Path', $newPath, $machineScope) | Out-Null

$userScope = [EnvironmentVariableTarget]::User
$newPath = [Environment]::GetEnvironmentVariable('Path', $userScope).Replace(";$binaryLocation", '')
[Environment]::SetEnvironmentVariable('Path', $newPath, $userScope) | Out-Null
