

# Logicool Gaming Software 5
Drivers and Logicool Profiler software for older Logicool devices, for supported devices see [the compatibility list](https://support.logi.com/hc/en-us/articles/360023375193-Logitech-game-devices-compatible-with-Logitech-Gaming-Software-5-10).

**This is a Japanese version of Logitech Gaming 5**, if you are looking for international version, it is provided in [logitechgaming5](https://community.chocolatey.org/packages/logitechgaming5).

If you have a more recent Logitech/Logicool device, you may need the newest version of Logitech/Logicool Gaming provided in:
* [logitechgaming](https://community.chocolatey.org/packages/logitechgaming) (International version)
* [logicoolgaming](https://community.chocolatey.org/packages/logicoolgaming) (Japanese version)

If you device is a new product, you might need [lghub](https://community.chocolatey.org/packages/lghub).

## Installation Parameters
* `/Language:` - which language edition to install
  - Supported values: `en`, `ja`
  - Default value: `ja`

### Examples
* Install English language variant
  ```
  choco install logicoolgaming5 --params "/Language:en"
  ```