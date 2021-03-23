$client = Get-Process -Name 'NLClientApp' -ErrorAction SilentlyContinue
if($client) {
    Stop-Process $client -Force
}

$service = Get-Service -Name 'NLSvc'
if($service) {
    Stop-Service $service -Force
}