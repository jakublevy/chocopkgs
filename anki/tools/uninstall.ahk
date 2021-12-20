#NoEnv
#NoTrayIcon
SendMode Input
SetWorkingDir %A_ScriptDir%
SetTitleMatchMode, 1
SetControlDelay, 150

winTitle := "Anki Uninstall"

WinWait, % winTitle
IfWinExist, % winTitle
{
   WinActivate, % winTitle
   ControlSend,, {Enter}, % winTitle,,, NA ; OK
}
