$kawAnime = Get-Process -Name 'kawanime' -ErrorAction SilentlyContinue
if($kawAnime) {
    Stop-Process $kawAnime -Force
}