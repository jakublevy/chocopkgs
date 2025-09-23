#Requires AutoHotkey v2.0
#SingleInstance Force

; Settings
SendMode "Input"
SetWorkingDir A_ScriptDir
SetTitleMatchMode 2
SetControlDelay 150

removeProfiles := "n"

WinWait("anki-console.exe")
WinActivate("anki-console.exe")
Send("y{Enter}")
Send(removeProfiles . "{Enter}")

WinWait("Anki Uninstall: Completed")
WinActivate("Anki Uninstall: Completed")
ControlClick("Button2", "Anki Uninstall: Completed")