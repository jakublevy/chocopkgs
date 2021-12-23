

# Filen Sync
Cross-platform desktop client for [filen.io](https://filen.io).

## Installation Parameters
* `/InstallDir:` - where to install the binaries
  - Default value: `"$env:localappdata\Programs\filen-desktop-client"`

### Examples
* Install into `"C:\Users\joe\filen-sync"` directory
  ```
  choco install filen-sync --params "/InstallDir:C:\Users\joe\filen-sync"
  ```