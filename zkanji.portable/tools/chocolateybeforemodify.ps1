$zkanji = Get-Process -Name 'zkanji' -ErrorAction SilentlyContinue
if($zkanji) {
    Stop-Process $zkanji -Force
}
