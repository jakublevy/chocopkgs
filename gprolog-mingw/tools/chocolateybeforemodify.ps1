$gprolog = Get-Process -Name "gprolog" -ErrorAction SilentlyContinue
if($gprolog) {
    Stop-Process $gprolog -Force
}