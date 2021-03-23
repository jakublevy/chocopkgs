**NOTE:** The following text is an excerpt from [the official website](https://www.meinfach.net/revosleep/).

# revoSleep
revoSleep lets your hard disk sleep in few seconds. You can lock different hard disks, so you can be sure they won't wake up.

## Here is the proceeding of revoSleep
1. Locks all partitions on the specified hard disk drive.
1. Dismounts all partitions on the specified hard disk drive.
1. Sends the specified hard disk to sleep.
1. Puts all volumes on the specified hard disk drive in offline state.
1. Deactivates the driver for the specified hard disk.
1. The locked hard disk drives won't wake up.
1. You can unlock/lock different hard disk drives.

## Usage of revoSleep
1. When you start revoSleep, a system tray icon is displayed in your taskbar.
2. You can double-click the system tray icon in order to display the program's user interface.
3. Here you can specify the hard disks that you want to send to sleep, take offline or deactivate (no software raid yet).
4. You can select the settings for each individual hard disk (click on 'Show Details') and send it to sleep. There might be issues with deactivating a hard disk as this can cause it to be woken up again (possibly since Windows 10). In this case, please only use the "Offline" setting together with the "Sleep" setting to avoid waking up a hard disk immediately.
5. By right-clicking the tray icon, you can activate or deactivate the specified settings for each processed hard disk (or use the corresponding buttons in the user interface).
6. All settings you have made are automatically saved.
7. Every time you start revoSleep the sleep mode of your hard disks is activated automatically.
8. You can also specify command line parameters to send individual hard disks to sleep or to wake them up (just run `revoSleep -h` in the CLI for more information).
9. Every time a hard disk is sent to sleep or woken up, the batch file `beforeSleep.bat` or `afterSleep.bat` is executed. (Please check the given batch files in revoSleep program directory for more information).

***

When you get Error Code 1 you have to use the windows driver (pciide*.sys) for your hard disk controllers! In the main affecting nforce drivers.

**PLEASE NOTE: There might be issues with deactivating a hard disk as this can cause it to be woken up again (possibly since Windows 10). In this case, please only use the offline setting together with the sleep setting to avoid waking up a hard disk immediately.**

For more information visit: [revoSleep board](https://revosleep.bboard.de).
