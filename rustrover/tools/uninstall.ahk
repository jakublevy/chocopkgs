#NoTrayIcon
SetTitleMatchMode(1)
SetControlDelay(-1)

deleteCache := false
deleteSettings := false

winTitle := "RustRover Uninstall"

WinWait(winTitle)
if WinExist(winTitle)
{
   WinActivate(winTitle)
   if (deleteCache) {
      ControlClick("Button5", winTitle,,,, "NA") ; Check cache
   }
   if (deleteSettings) {
      ControlClick("Button6", winTitle,,,, "NA") ; Check settings
   }

   Sleep(50)
   ControlClick("Button2", winTitle,,,, "NA") ; Uninstall

   Sleep(100)
   while ControlGetEnabled("Button2", winTitle) = 0
   {
      Sleep(100)
   }
   Sleep(50)
   ControlClick("Button2", winTitle,,,, "NA") ; Close
}
