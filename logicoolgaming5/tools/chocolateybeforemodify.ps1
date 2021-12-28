$profiler = Get-Process -Name 'LWEMon' -ErrorAction SilentlyContinue
if($profiler) {
    Stop-Process $profiler -Force
}