

# PDFtk
PDFtk (short for PDF Toolkit) is a toolkit for manipulating Portable Document Format (PDF) documents.

**This is a port of pdftk into Java**. If you are looking for the original version written in C++, it is available as [pdftk](https://community.chocolatey.org/packages/pdftk) package.

The current goals are to keep functionality as compatible with the original as it is reasonable, to fix any issues present in the original (correctness takes precedence over compatibility, see the differences), and to clean up the code. New functionality may be added, but it is not a priority. So far all code has been manually translated and it passes the test suite of php-pdftk, but more testing is needed. Due to the differences between C++ and Java, it is likely that a few bugs have sneaked in with respect to the original; any help in catching them will be appreciated.

## Dependencies
* Java Runtime ≥ 8

## Installation Parameters
* `/AddToSystemPath:` - should `"$(Get-ToolsLocation)\pdftk-java"` be added to the System Path variable
    - Supported values: `yes`, `no`
    - Default value: `yes`
* `/AddToUserPath:` - should `"$(Get-ToolsLocation)\pdftk-java"` be added to the User Path variable
    - Supported values: `yes`, `no`
    - Default value: `no`

### Examples
* Install and add only to the User Path variable
    ```
    choco install pdftk-java --params "'/AddToUserPath:yes /AddToSystemPath:no'"
    ```
* Install and do not add anything to environment variables
    ```
    choco install pdftk-java --params "'/AddToSystemPath:no /AddToUserPath:no'"
    ```