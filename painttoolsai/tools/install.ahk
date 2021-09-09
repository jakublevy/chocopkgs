#NoEnv
#NoTrayIcon
SendMode Input
SetWorkingDir %A_ScriptDir%
SetTitleMatchMode, 1
SetControlDelay -1

winTitle := "Installation for PaintTool SAI"
alreadyExists := "Specified folder is already existing. Do you overwrite this folder?"
finished := "Installation finished."
installDir := "C:\PaintToolSAI"
desktopIcon := False
saiAssoc := True

WinWait, % winTitle
IfWinExist, % winTitle
{
   WinActivate, % winTitle
   
   if !desktopIcon {
      ControlClick, Button2, % winTitle,,,, NA ; uncheck desktop shortcut
   }
   
   if !saiAssoc {
      ControlClick, Button5, % winTitle,,,, NA ; uncheck .sai file assoc
   }
   
   ControlSetText, Edit1, % installDir, % winTitle,,, NA ; set installation path
   ControlClick, Button6, % winTitle,,,, NA ; Install
   
   WinWait, % winTitle, % alreadyExists, 1
   IfWinExist, % winTitle, % alreadyExists 
   {
      WinActivate, % winTitle, % alreadyExists  
      ControlClick, Button1, % winTitle, % alreadyExists,,, NA ; Yes
   }
   
   WinWait, % winTitle, % finished
   IfWinExist, % winTitle, % finished 
   {
      WinActivate, % winTitle, % finished  
      ControlClick, Button1, % winTitle, % finished,,, NA ; OK
   }
}
