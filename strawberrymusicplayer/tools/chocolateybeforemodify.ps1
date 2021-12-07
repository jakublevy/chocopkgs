$strawberry = Get-Process -Name 'strawberry' -ErrorAction SilentlyContinue
if($strawberry) {
    Stop-Process $strawberry -Force
}