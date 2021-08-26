$processes = Get-Process -Name 'clipstudio*' -ErrorAction SilentlyContinue
$processes | ? { $_.Name -notmatch 'Paint' }  | % { Stop-Process $_ -Force }