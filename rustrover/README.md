

Jetbrains IDE for Rust.

See [https://www.jetbrains.com/rust/](https://www.jetbrains.com/rust/) for more information.

## Installation Parameters
* `/AddBinToPath` - whether to add "bin" folder to PATH
  - Not used by default
* `/AddToContextMenu` - whether to add "Open Folder as Project" into the context menu
  - Not used by default
* `/CreateFileAssoc` - whether to associate with .rs files
  - Not used by default
* `/DesktopIcon` - whether to create desktop shortcut
  - Not used by default
* `/InstallDir` - where to install binaries
  - Default value: `"$env:ProgramFiles\JetBrains\RustRover [VERSION]"`

### Examples
* Install into `D:\Rust-IDE` directory
  ```
  choco install rustrover --params "/InstallDir:D:\Rust-IDE"
  ```

* Install and use `/AddBinToPath`, `/AddToContextMenu` and `/InstallDir`
  ```
  choco install rustrover --params "'/AddBinToPath /AddToContextMenu /InstallDir:D:\Rust-IDE'"
  ```
## Uninstallation Parameters
* `/DeleteCache` - whether to delete cache and local history
  - Not used by default
* `/DeleteSettings` - whether to delete settings and installed plugins
  - Not used by default

### Examples
* Uninstall and delete both cache and settings
  ```
  choco uninstall rustrover --params "'/DeleteCache /DeleteSettings'"
  ```