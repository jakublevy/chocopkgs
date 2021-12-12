

**NOTE:** This is commercial software with 30-day trial period, after expiration a valid license key is required. You can purchase one from [the official website](https://visualgdb.com).

**NOTE:** VisualGDB requires Microsoft Visual Studio as a dependency, see [system requirements](https://visualgdb.com/download).

# VisualGDB
VisualGDB integrates the GNU toolchain (GCC/GDB) into Visual Studio. With VisualGDB installed, Visual Studio can be used for the development and debugging of many applications based on GNU tools: embedded firmware, native Android code, MacOS drivers, Linux drivers, Linux applications, and many more...

## Installation Parameters
* `/InstallDir:` - where to install the binaries
  - Default value:
    - `"${env:ProgramFiles(x86)}\Sysprogs\VisualGDB"` on 64-bit Windows
    - `"$env:ProgramFiles\Sysprogs\VisualGDB"` on 32-bit Windows

### Examples
* Install into `D:\VisualGDB` directory
  ```
  choco install visualgdb --params "/InstallDir:D:\visualgdb"
  ```