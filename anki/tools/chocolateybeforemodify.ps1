$anki = Get-Process -Name 'Anki' -ErrorAction SilentlyContinue
while($anki) {
    $anki.CloseMainWindow() | Out-Null
    $anki = Get-Process -Name 'Anki' -ErrorAction SilentlyContinue
}