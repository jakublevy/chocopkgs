# PDFtk
PDFtk (short for PDF Toolkit) is a toolkit for manipulating Portable Document Format (PDF) documents.

**This is a port of pdftk into Java**. If you are looking for original version written in C++, it is available as [pdftk](https://community.chocolatey.org/packages/pdftk) package.

The current goals are to keep functionality as compatible with the original as it is reasonable, to fix any issues present in the original (correctness takes precedence over compatibility, see the differences), and to clean up the code. New functionality may be added, but it is not a priority. So far all code has been manually translated and it passes the test suite of php-pdftk, but more testing is needed. Due to the differences between C++ and Java, it is likely that a few bugs have sneaked in with respect to the original; any help in catching them will be appreciated.

## Dependencies
* Java Runtime ≥ 8

## Installation Parameters
* `/JavaExePath:` - Path to `java.exe`
    - Default value: 
        - `"$env:JAVA_HOME\bin\java.exe"` if `$env:JAVA_HOME` is defined
        - `java.exe` otherwise

### Examples
* Install and configure pdftk to use `C:\openjdk-11.0.13_8\bin\java.exe` as Java executable
    ```
    choco install pdftk-java --params "/JavaExePath:C:\openjdk-11.0.13_8\bin\java.exe"
    ```