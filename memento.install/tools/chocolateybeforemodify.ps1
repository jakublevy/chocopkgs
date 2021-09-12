$memento = Get-Process -Name 'Memento' -ErrorAction SilentlyContinue
if($memento) {
    Stop-Process $memento -Force
}