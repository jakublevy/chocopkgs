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
   Loop
   {
      ControlSend,, {Enter}, % winTitle,,, NA ; OK
      Sleep, 150
      ControlGet, isVisible, Visible,, Button1, % winTitle,,, NA
   } Until isVisible
}
