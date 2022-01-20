

![](https://cdn.jsdelivr.net/gh/jakublevy/chocopkgs/zkanji/logo.png)

zkanji is a free and open-source study tool and dictionary of the Japanese language. It has several useful features for beginners and advanced students alike. Dictionary, example sentences, kanji search and information with animated stroke order diagrams, vocabulary list printing, study functions and much more.

## Installation Parameters
* `/InstallDir:` - where to install the binaries
  - Default value:
    - `"$env:ProgramFiles(x86)\zkanji"` on 64-bit Windows
    - `"$env:ProgramFiles\zkanji"` on 32-bit Windows
* `/CreateDesktopIcon` - creates a desktop icon
    - Not created by default

### Examples
* Install into `D:\zkanji` directory and create a desktop icon
  ```
  choco install zkanji --params "'/InstallDir:D:\zkanji /CreateDesktopIcon'"
  ```