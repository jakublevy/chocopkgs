$scantailor = Get-Process -Name "scantailor" -ErrorAction SilentlyContinue
if($scantailor) {
    Stop-Process $scantailor -Force
}