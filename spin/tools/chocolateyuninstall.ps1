$shortcutsToRemove = @("$env:userprofile\Desktop\iSpin.lnk", 
                     "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\iSpin.lnk",
                     "$env:AppData\Microsoft\Windows\Start Menu\Programs\iSpin.lnk")


$shortcutsToRemove | % { Remove-Item `
                            -Path $_ `
                            -ErrorAction SilentlyContinue `
                            -Force
}