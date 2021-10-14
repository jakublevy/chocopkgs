#NoEnv
#NoTrayIcon
SendMode Input
SetWorkingDir %A_ScriptDir%
SetTitleMatchMode, 1
SetControlDelay, 150

winTitle := "zkanji"
installDir := "C:\Program Files (x86)\zkanji"
desktopIcon := False

WinWait, % winTitle
IfWinExist, % winTitle
{
   WinActivate, % winTitle
   Loop
   {
      ControlSend,, {Enter}, % winTitle,,, NA ; Next
      Sleep, 150
      ControlGet, isVisible, Visible,, Edit1, % winTitle,,, NA
   } Until isVisible

   ControlSetText, Edit1, % installDir, % winTitle,,, NA ; set installation path
   ControlSend,, {Enter}, % winTitle,,, NA ; Next
   Sleep, 150

   if !desktopIcon {
      ControlClick, Button5, % winTitle,,,, NA ; uncheck desktop shortcut
   }
   ControlSend,, {Enter}, % winTitle,,, NA ; Install
   Sleep, 1000

   ControlGet, available, Enabled,, Button2, % winTitle,,, NA
   While (available = False) {
      Sleep, 100
      ControlGet, available, Enabled,, Button2, % winTitle,,, NA
   }

   Sleep, 200
   ControlClick, Button4, % winTitle,,,, NA ; uncheck run zkanji
   ControlClick, Button2, % winTitle,,,, NA ; Finish
}
