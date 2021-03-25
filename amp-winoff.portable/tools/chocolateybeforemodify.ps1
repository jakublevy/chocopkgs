$winoff = Get-Process -Name 'WinOFF' -ErrorAction SilentlyContinue
if($winoff) {
    Stop-Process $winoff -Force
}