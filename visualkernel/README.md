**NOTE:** This is commercial software with 30-day trial period, after expiration a valid license key is required. You can purchase one from [the official website](https://sysprogs.com/VisualKernel).

**NOTE:** VisualKernel requires Microsoft Visual Studio as a dependency, see [system requirements](https://sysprogs.com/VisualKernel/download).

# VisualKernel
VisualKernel integrates Linux kernel debugging into Visual Studio.
## Features
* Debug Linux Kernel with Visual Studio
* Support for Raspberry Pi 3, i.MX6 and other devices
* IntelliSense support even for GNU extensions
* Automatic symbol management
* ...

## Installation Parameters
* `/InstallDir:` - where to install the binaries
  - Default value:
    - `"${env:ProgramFiles(x86)}\Sysprogs\VisualKernel"` on 64-bit Windows
    - `"$env:ProgramFiles\Sysprogs\VisualKernel"` on 32-bit Windows

### Examples
* Install into `D:\VisualKernel` directory
  ```
  choco install visualkernel --params "/InstallDir:D:\visualkernel"
  ```