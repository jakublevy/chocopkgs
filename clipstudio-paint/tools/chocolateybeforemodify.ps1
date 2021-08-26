$processes = Get-Process -Name 'clipstudio*' -ErrorAction SilentlyContinue
$processes | ? { $_.Name -notmatch 'Modeler' }  | % { Stop-Process $_ -Force }