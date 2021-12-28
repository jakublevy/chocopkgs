#NoEnv
#NoTrayIcon
SendMode Input
SetWorkingDir %A_ScriptDir%
SetTitleMatchMode, 1
SetControlDelay, 150

installerWindow = ahk_exe MSetup.exe
setupWindow = ahk_exe WMWizard.exe
profilerWindow = ahk_exe LWEMon.exe

selectedLanguage := "ja"

language := []

; English
language["en"] := 1

; Japanese
language["ja"] := 2

WinWait, % installerWindow
IfWinExist, % installerWindow
{
   WinActivate, % installerWindow
   Control, Choose, % language[selectedLanguage], ComboBox1, % installerWindow,,,, NA ; Language select

   ; Software Installer
   Loop
   {
      ControlClick, Button7, % installerWindow,,,, NA ; Next
      ControlGet, isEnabled, Enabled,, Button7, % installerWindow,,,, NA
   } Until !isEnabled

   ControlClick, Button8, % installerWindow,,,, NA ; I accept
   ControlClick, Button7, % installerWindow,,,, NA ; Install

   ; Software Setup
   WinWait, % setupWindow
   IfWinExist, % setupWindow 
   {
      WinActivate, % setupWindow
      ControlClick, Button2, % setupWindow,,,, NA ; Next
      
      ; Loop over all possibly connected devices and click OK
      Loop 
      {
         Loop
         {
            Sleep, 100
            ControlGet, isVisible, Visible,, Button3, % setupWindow,,,, NA
         } Until isVisible

         Loop
         {
            ControlClick, Button3, % setupWindow,,,, NA ; Next
            ControlGet, isVisible, Visible,, Button3, % setupWindow,,,, NA
         } Until !isVisible

         ControlGet, finishEnabled, Enabled,, Button6, % setupWindow,,,, NA
         If !finishEnabled
         {
            Loop
            {
               ControlClick, Button4, % setupWindow,,,, NA ; OK
               ControlGet, isEnabled, Enabled,, Button4, % setupWindow,,,, NA
               ControlGet, finishEnabled, Enabled,, Button6, % setupWindow,,,, NA
            } Until !isEnabled or finishEnabled
         }
      } Until finishEnabled

      ControlClick, Button1, % setupWindow,,,, NA ; Do not view Readme
      ControlClick, Button6, % setupWindow,,,, NA ; Finish
   }

   ; Software Installer
   WinActivate, % installerWindow
   ControlClick, Button7, % installerWindow,,,, NA ; Done
   Sleep, 2000
   
   ; Profiler
   WinWait, % profilerWindow,, 3
   IfWinExist, % profilerWindow
   {
      WinActivate, % profilerWindow
      ControlClick, Button2, % profilerWindow,,,, NA ; Cancel
   }
}
