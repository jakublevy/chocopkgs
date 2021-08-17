![](https://cdn.jsdelivr.net/gh/jakublevy/chocopkgs/winfetch/logo.png)

![](https://cdn.jsdelivr.net/gh/jakublevy/chocopkgs/winfetch/preview.png)

Winfetch is a command-line system information utility written in PowerShell 5+. Winfetch displays information about your operating system, software and hardware in an aesthetic and visually pleasing way.

The overall purpose of Winfetch is to be used in screenshots of your system. Winfetch shows the information other people want to see. There are other tools available for proper system statistic/diagnostics.

The information by default is displayed alongside your operating system's logo. You can further configure Winfetch to instead use an image, your wallpaper or nothing at all.

According to benchmarks done with Hyperfine, Winfetch on Windows is faster than Neofetch running on Bash emulators like MSYS (Git Bash) or Cygwin.

## Parameters
* `/AddToSystemPath:` - should `"$(Get-ToolsLocation)\winfetch"` be added to the System Path variable
    - Default value: `yes`
* `/AddToUserPath` - should `"$(Get-ToolsLocation)\winfetch"` be added to the User Path variable
    - Default value: `no`

### Examples
* Install and add only to the User Path variable
    ```
    choco install winfetch --params "'/AddToUserPath:yes /AddToSystemPath:no'"
    ```
* Install and do not add anything to environment variables
    ```
    choco install winfetch --params "'/AddToSystemPath:no /AddToUserPath:no'"
    ```