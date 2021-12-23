$filen = Get-Process -Name 'Filen Sync' -ErrorAction SilentlyContinue
if($filen) {
    Stop-Process $filen -Force
}