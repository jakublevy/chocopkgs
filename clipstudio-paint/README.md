**NOTE:** This is commercial software with a trial period, after expiration, a valid license is required. You can purchase one from [the official website](https://www.clipstudio.net/en).

# Clip Studio Paint
Clip Studio Paint is a software for digital creation of manga (comics), general illustrations and 2D animations. It is designed for use with a stylus and a graphics tablet or tablet computer. It has drawing tools which emulate natural media such as pencils, ink pens, and brushes, as well as patterns and decorations. It is distinguished from similar programs by features designed for creating comics: tools for creating panel layouts, perspective rulers, sketching, inking, applying tones and textures, coloring, and creating word balloons and captions. 

## Installation Parameters
* `/DesktopIcon:` - should desktop icons be created
  - Supported values: `yes`, `no`
  - Default value: `no`
* `/InstallDir:` - where to install the binaries
  - Default value: `"$env:ProgramFiles\CELSYS"`
* `/Language:` - which language edition to install
  - Supported values: `chinese`, `english`, `french`, `german`, `japanese`, `korean`, `spanish`
  - Default value: `english`

### Examples
* Install into `D:\clipstudio-paint` directory
  ```
  choco install clipstudio-paint --params "/InstallDir:D:\clipstudio-paint"
  ```
* Install Japanese language variant into `D:\clipstudio-paint`
  ```
  choco install clipstudio-paint --params "'/InstallDir:D:\clipstudio-paint /Language:japanese'"
  ```
* Install Spanish language variant
  ```
  choco install clipstudio-paint --params "/Language:spanish"
  ```
* Install and create desktop icons
  ```
  choco install clipstudio-paint --params "/DesktopIcon:yes"
  ```