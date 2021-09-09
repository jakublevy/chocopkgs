#NoEnv
#NoTrayIcon
SendMode Input
SetWorkingDir %A_ScriptDir%
SetTitleMatchMode, 1
SetControlDelay -1

winTitle := "Uninstallation for PaintTool SAI"
finished := "Uninstallation finished."

WinWait, % winTitle
IfWinExist, % winTitle
{
   WinActivate, % winTitle
   ControlClick, Button1, % winTitle,,,, NA ; Uninstall
   
   WinWait, % winTitle, % finished
   IfWinExist, % winTitle, % finished 
   {
      WinActivate, % winTitle, % finished
      ControlClick, Button1, % winTitle, % finished,,, NA ; OK
   }
}
