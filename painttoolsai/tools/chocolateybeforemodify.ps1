$sai = Get-Process -Name 'sai' -ErrorAction SilentlyContinue
if($sai) {
    Stop-Process $sai -Force
}