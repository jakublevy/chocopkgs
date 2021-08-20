$kcc = Get-Process -Name "KCC" -ErrorAction SilentlyContinue
if($kcc) {
    Stop-Process $kcc -Force
}