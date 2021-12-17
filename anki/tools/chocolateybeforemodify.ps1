$anki = Get-Process -Name 'Anki' -ErrorAction SilentlyContinue
while($anki) {
    $anki.CloseMainWindow()
    $anki = Get-Process -Name 'Anki' -ErrorAction SilentlyContinue
}