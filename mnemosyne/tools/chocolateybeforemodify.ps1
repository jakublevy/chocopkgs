$mnemosyne = Get-Process -Name "mnemosyne" -ErrorAction SilentlyContinue
if($mnemosyne) {
    Stop-Process $mnemosyne -Force
}