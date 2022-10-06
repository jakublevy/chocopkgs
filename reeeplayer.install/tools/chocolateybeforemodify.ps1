$reeeplayer = Get-Process -Name 'ReeePlayer' -ErrorAction SilentlyContinue
if($reeeplayer) {
    Stop-Process $reeeplayer -Force
}