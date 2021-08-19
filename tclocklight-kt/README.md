# TClock Light kt

TClock Light kt is a modified version of TClock Light by [K.Takata](https://github.com/k-takata).

## New features
* Supports Windows Vista and later (x86/x64).
* Increases the precision of SNTP.
* Supports some new text formats.
* etc.

## Documentation
The following documents are available. (all in Japanese)
* [readme-kt.txt](https://github.com/k-takata/TClockLight/blob/master/readme-kt.txt): Readme for the "kt" version
* [config-kt.txt](https://github.com/k-takata/TClockLight/blob/master/config-kt.txt): How to configure TClock Light kt
* [format-kt.txt](https://github.com/k-takata/TClockLight/blob/master/format-kt.txt): Format strings that can be used in TClock Light kt
* [readme.html](https://github.com/k-takata/TClockLight/blob/master/readme.html): The original readme by Kazubon



## Parameters
* `/AddToSystemStartup:` - should TClock start after bootup
    - Default value: `yes`
* `/AddToUserStartup:` - should TClock start after the current user logins
    - Default value: `no`

### Examples
* Install and auto-start only after the current user logins
    ```
    choco install tclocklight-kt --params "'/AddToSystemStartup:no /AddToUserStartup:yes'"
    ```
* Install and never start automatically
    ```
    choco install tclocklight-kt --params "'/AddToSystemStartup:no /AddToUserStartup:no'"
    ```