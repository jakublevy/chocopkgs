**NOTE:** The following text is for the most part an excerpt from [the official website](https://www.netlimiter.com/docs/infobar).

# NetLimiter InfoBar
NetLimiter InfoBar is free of charge tool for NetLimiter users, which's purpose is to display most important NetLimiter information directly on system's Taskbar.

## System Requirements
InfoBar needs working [NetLimiter](https://community.chocolatey.org/packages/netlimiter) installation in order to run. Currently, only **Windows 10 64bit** systems are supported.

## Installation Parameters
* `/InstallationPath:` - where to install the binaries
  - Default value: `"$env:ProgramFiles\Locktime Software\NetLimiter InfoBar"`

### Examples
* Install into `D:\netlimiter-infobar` directory
  ```
  choco install netlimiter --params "/InstallationPath:"D:\netlimiter-infobar""
  ```

## After Installation
*After successful installation* process you need to **manually enable** it:
* Right-click on system Taskbar.
* Select `Toolbars`.
* Click on `NetLimiter InfoBar`. Please, be patient here as it could take few seconds for InfoBar to appear in the menu.

![](https://cdn.jsdelivr.net/gh/jakublevy/chocopkgs/netlimiter-infobar/NLToolbar-Activation-Detail.png)

## Functionality
With *InfoBar* users can keep [NetLimiter client](https://www.netlimiter.com/docs/user-gui-client) closed and only open it when something important needs their attention.

![](https://cdn.jsdelivr.net/gh/jakublevy/chocopkgs/netlimiter-infobar/NLToolBar-Requests.png)

*InfoBar* does:
* It displays current **transfer rates** for selected [Zone](https://www.netlimiter.com/docs/basic-concepts/zones).
* In case of any problem it shows **an alert**.
* It alerts user when any Blocker request needs his attention.
* Using a **context menu** user can open [NetLimiter client](https://www.netlimiter.com/docs/user-gui-client) or quickly **enable/disable** [Limiter](https://www.netlimiter.com/docs/basic-concepts/limits), [Blocker](https://www.netlimiter.com/docs/basic-concepts/blocker) or [Priorities](https://www.netlimiter.com/docs/basic-concepts/priorities).
