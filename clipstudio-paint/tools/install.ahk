#NoEnv
#NoTrayIcon
SendMode Input
SetWorkingDir %A_ScriptDir%
SetTitleMatchMode, 1
SetControlDelay -1

winTitle := "CLIP STUDIO PAINT - InstallShield Wizard"

WinWait, % winTitle
IfWinExist, % winTitle
{
   WinActivate, % winTitle
   Sleep, 50
   ControlClick, Button4, % winTitle,,,, NA ; I accept the terms...
   Sleep, 50
   ControlClick, Button1, % winTitle,,,, NA ; Next >
}