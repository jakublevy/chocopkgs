

# Anki
Anki is a program which makes remembering things easy. Because it's a lot more efficient than traditional study methods, you can either greatly decrease your time spent studying, or greatly increase the amount you learn. 

Anyone who needs to remember things in their daily life can benefit from Anki. Since it is content-agnostic and supports images, audio, videos and scientific markup (via LaTeX), the possibilities are endless.
For example:
* Learning a language
* Studying for medical and law exams
* Memorizing people's names and faces
* Brushing up on geography
* Mastering long poems
* Even practicing guitar chords!

## Installation Parameters
* `/CreateDesktopIcon` - creates a desktop icon
    - Not created by default
* `/InstallDir:` - where to install the binaries
  - Default value: `"$env:ProgramFiles\Anki"`
* `/Qt5` - installs Anki with Qt 5
    - By default (without this parameter) Qt 6 is used

### Examples
* Install into `D:\anki` directory
  ```
  choco install anki --params "/InstallDir:D:\anki"
  ```
* Install and create desktop icon
  ```
  choco install anki --params "/CreateDesktopIcon"
  ```
* Install into `D:\anki` directory and create a desktop icon
  ```
  choco install anki --params "'/CreateDesktopIcon /InstallDir:D:\anki'"
  ```
* Install with Qt 5
  ```
  choco install anki --params "/Qt5"
  ```