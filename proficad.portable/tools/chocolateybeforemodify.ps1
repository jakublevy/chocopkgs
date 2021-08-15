$proficad = Get-Process -Name "proficad" -ErrorAction SilentlyContinue
if($proficad) {
    Stop-Process $proficad -Force
}