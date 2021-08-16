**NOTE:** The following text is for the most part an excerpt from [the official website](https://deadbeef.sourceforge.io).

# DeaDBeeF
DeaDBeeF (as in [0xDEADBEEF](http://en.wikipedia.org/wiki/Hexspeak)) is a modular multiple-platform audio player for desktop operating systems.

DeaDBeeF lets you play variety of audio formats, convert between them, customize the UI almost any way you want, and use many [additional plugins](https://deadbeef.sourceforge.io/plugins.html) which can extend it even more.

![](https://cdn.jsdelivr.net/gh/jakublevy/chocopkgs/deadbeef/preview.png)
The screenshot above demonstrates a highly customized DeaDBeeF, running on Linux with several additional plugins

## Parameters
* `/AddToUserPath` - should `"$(Get-ToolsLocation)\deadbeef-x86_64"` be added to the User Path variable
    - Default value: `yes`
* `/AddToSystemPath:` - should `"$(Get-ToolsLocation)\deadbeef-x86_64"` be added to the System Path variable
    - Default value: `no`

### Examples
* Install and add only to the System Path variable
    ```
    choco install deadbeef.portable --params "'/AddToSystemPath:yes /AddToUserPath:no'"
    ```
* Install and do not add anything to environment variables
    ```
    choco install deadbeef.portable --params "'/AddToSystemPath:no /AddToUserPath:no'"
    ```