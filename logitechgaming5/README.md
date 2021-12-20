

# Logitech Gaming Software 5
Drivers and Logitech Profiler software for older Logitech devices, for supported devices see [the compatibility list](https://support.logi.com/hc/en-us/articles/360023375193-Logitech-game-devices-compatible-with-Logitech-Gaming-Software-5-10).

If you have a more recent Logitech device, you may need the newest version of Logitech Gaming provided in [logitechgaming](https://community.chocolatey.org/packages/logitechgaming), or [lghub](https://community.chocolatey.org/packages/lghub).

## Installation Parameters
* `/Language:` - which language edition to install
  - Supported values: `da`, `de`, `en`, `el`, `es`, `fi`, `fr`, `it`, `ko`, `nl`, `no`, `pt`, `sv`, `zh-CN`, `zh-TW`
  - Default value: `en`

### Examples
* Install French language variant
  ```
  choco install logitechgaming5 --params "/Language:fr"
  ```
* Install Traditional Chinese language variant
  ```
  choco install logitechgaming5 --params "/Language:zh-TW"