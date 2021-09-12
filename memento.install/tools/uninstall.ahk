#NoEnv
#NoTrayIcon
SendMode Input
SetWorkingDir %A_ScriptDir%
SetTitleMatchMode, 1
SetControlDelay -1

winTitle := "Memento Uninstall"

WinWait, % winTitle
IfWinExist, % winTitle
{
   WinActivate, % winTitle
   ControlClick, Button1, % winTitle,,,, NA ; OK
}
