$materialMaker = Get-Process -Name 'material_maker' -ErrorAction SilentlyContinue
if($materialMaker) {
    Stop-Process $materialMaker -Force
}