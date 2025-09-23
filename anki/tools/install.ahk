#Requires AutoHotkey v2.0
#SingleInstance Force

; Settings
SendMode "Input"
SetWorkingDir A_ScriptDir
SetTitleMatchMode 2
SetControlDelay 150

WinWait("Anki Setup: Installation Folder")

; Activate the window
WinActivate("Anki Setup: Installation Folder")

; Try to click the Install button
Sleep(100)
ControlClick("Button2", "Anki Setup: Installation Folder")

WinWait("anki-console.exe")
WinActivate("anki-console.exe")
Send("1{Enter}")


WinWait("Anki",,, "console")
SetTitleMatchMode 2
WinClose("anki-console.exe")
pid := WinGetPID("Anki")
ProcessClose(pid)