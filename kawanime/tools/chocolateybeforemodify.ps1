$kawAnime = Get-Process -Name 'kawanime' -ErrorAction SilentlyContinue
$kawAnime | % { Stop-Process $_ -Force }