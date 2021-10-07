**NOTE:** This is commercial software with a trial period, after expiration, a valid license is required. You can purchase one from [the official website](https://www.systemax.jp/en/sai).

![](https://cdn.jsdelivr.net/gh/jakublevy/chocopkgs/painttoolsai/sai_logo.png)

PaintTool SAI is high quality and lightweight painting software for amazing anti-aliased paintings.

## Features
* Digitizers with pressure are fully supported.
* Amazing anti-aliased drawings.
* Highly accurate composition with 16-bit ARGB channels.
* Simple but powerful user interface, easy to learn.
* Intel MMX Technology is fully supported.
* Data protection to avoid loss.

## Installation Parameters
* `/AssocSai:` - should .sai files be associated
  - Supported values: `yes`, `no`
  - Default value: `yes`
* `/DesktopIcon:` - should desktop icons be created
  - Supported values: `yes`, `no`
  - Default value: `no`
* `/InstallDir:` - where to install the binaries
  - Default value: `"$env:SystemDrive\PaintToolSAI"`
* `/Language:` - which language edition to install
  - Supported values: `english`, `japanese`
  - Default value: `english`

### Examples
* Install into `D:\painttoolsai` directory
  ```
  choco install painttoolsai --params "/InstallDir:D:\painttoolsai"
  ```
* Install Japanese language variant into `D:\painttoolsai`
  ```
  choco install painttoolsai --params "'/InstallDir:D:\painttoolsai /Language:japanese'"
  ```
* Install and create desktop icon
  ```
  choco install painttoolsai --params "/DesktopIcon:yes"
  ```
* Install and do not associate with .sai files
  ```
  choco install painttoolsai --params "/AssocSai:no"
  ```