$kcc = Get-Process -Name "proficad" -ErrorAction SilentlyContinue
if($kcc) {
    Stop-Process $kcc -Force
}