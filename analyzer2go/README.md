

**NOTE:** This is commercial software with 15-day trial period, after expiration a valid license key is required. You can purchase one from [the official website](https://sysprogs.com/analyzer2go).

# Analyzer2Go
Analyzer2Go is an application that turns your development board into a logic analyzer.

## Supported boards
* https://sysprogs.com/analyzer2go/?page=boards

## Features
* https://sysprogs.com/analyzer2go

## Installation Parameters
* `/InstallDir:` - where to install the binaries
  - Default value:
    - `"${env:ProgramFiles(x86)}\Sysprogs\Analyzer2Go"` on 64-bit Windows
    - `"$env:ProgramFiles\Sysprogs\Analyzer2Go"` on 32-bit Windows

### Examples
* Install into `D:\Analyzer2Go` directory
  ```
  choco install analyzer2go --params "/InstallDir:D:\Analyzer2Go"
  ```