$deadbeef = Get-Process -Name 'deadbeef' -ErrorAction SilentlyContinue
if($deadbeef) {
    Stop-Process $deadbeef -Force
}
