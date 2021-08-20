$lpsolveIDE = Get-Process -Name "LpSolveIDE" -ErrorAction SilentlyContinue
if($lpsolveIDE) {
    Stop-Process $lpsolveIDE -Force
}