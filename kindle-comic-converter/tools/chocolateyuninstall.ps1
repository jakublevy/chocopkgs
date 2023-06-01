$ErrorActionPreference = 'Stop'
$shortcutsToRemove = @("$env:AppData\Microsoft\Windows\Start Menu\Programs\Kindle Comic Converter.lnk", 
                       "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Kindle Comic Converter.lnk")


$shortcutsToRemove | % { Remove-Item `
                            -Path $_ `
                            -ErrorAction SilentlyContinue `
                            -Force
}