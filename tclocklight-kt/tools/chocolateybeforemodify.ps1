$tclock = Get-Process -Name "tclock" -ErrorAction SilentlyContinue
if($tclock) {
    Stop-Process $tclock -Force
}