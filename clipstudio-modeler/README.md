# Clip Studio Modeler
Clip Studio Modeler is a freeware software for setting up 3D materials for use in Clip Studio Paint. It supports many widely used formats for 3D models, which can then be used as materials in Clip Studio Paint.


## Installation Parameters
* `/DesktopIcon:` - should desktop icons be created
  - Supported values: `yes`, `no`
  - Default value: `no`
* `/InstallDir:` - where to install the binaries
  - Default value: `"$env:ProgramFiles\CELSYS"`
* `/Language:` - which language edition to install
  - Supported values: `english`, `japanese`
  - Default value: `english`

### Examples
* Install into `D:\clipstudio-modeler` directory
  ```
  choco install clipstudio-modeler --params "/InstallDir:D:\clipstudio-modeler"
  ```
* Install Japanese language variant into `D:\clipstudio-modeler`
  ```
  choco install clipstudio-modeler --params "'/InstallDir:D:\clipstudio-modeler /Language:japanese'"
  ```
* Install and create desktop icons
  ```
  choco install clipstudio-modeler --params "/DesktopIcon:yes"
  ```