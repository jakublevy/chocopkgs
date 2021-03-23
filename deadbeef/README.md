**NOTE:** The following text is for the most part an excerpt from the [official website](https://deadbeef.sourceforge.io).

# DeaDBeeF
DeaDBeeF (as in [0xDEADBEEF](http://en.wikipedia.org/wiki/Hexspeak)) is a modular multiple-platform audio player for desktop operating systems.

DeaDBeeF lets you play variety of audio formats, convert between them, customize the UI almost any way you want, and use many [additional plugins](https://deadbeef.sourceforge.io/plugins.html) which can extend it even more.

![](https://cdn.jsdelivr.net/gh/jakublevy/chocopkgs/deadbeef/preview.png)
The screenshot above demonstrates a highly customized DeaDBeeF, running on Linux with several additional plugins

## Parameters
* `/InstallationPath:` - where to install the binaries
  - Default value: `"$env:ProgramFiles\DeaDBeeF"`
* `/CreateDesktopIcon` - creates a desktop icon
  - Not created by default
* `/AssociateAudioFiles` - associates DeaDBeef as the default app for all supported audio files
  - Not associated by default

### Examples
* Install into `D:\deadbeef` directory and create a desktop icon
  ```
  choco install deadbeef --params "/InstallationPath:"D:\deadbeef" /CreateDesktopIcon"
  ```

* Install with audio file associations
  ```
  choco install deadbeef --params "/AssociateAudioFiles"
  ```

* Install with audio file associations and create desktop icon
  ```
  choco install deadbeef --params "/AssociateAudioFiles /CreateDesktopIcon"
  ```