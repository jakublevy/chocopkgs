# ScanTailor Advanced
The ScanTailor version that merges the features of the ScanTailor Featured and ScanTailor Enhanced versions, brings new ones and fixes.

ScanTailor Advaned is an interactive post-processing tool for scanned pages. It performs operations such as:
* [page splitting](https://github.com/scantailor/scantailor/wiki/Split-Pages),
* [deskewing](https://github.com/scantailor/scantailor/wiki/Deskew),
* [adding/removing borders](https://github.com/scantailor/scantailor/wiki/Page-Layout),
* [selecting content](https://github.com/scantailor/scantailor/wiki/Select-Content)
* ... and others.

You give it raw scans, and you get pages ready to be printed or assembled into a PDF or [DjVu](http://elpa.gnu.org/packages/djvu.html) file. Scanning, optical character recognition, and assembling multi-page documents are out of scope of this project.

For more information about ScanTailor Advanced see [the official README.me](https://github.com/4lex4/scantailor-advanced/blob/master/README.md).

## Parameters
* `/InstallationPath:` - where to install the binaries
    - Default value: `"$env:ProgramFiles\ScanTailor Advanced"`

### Examples
* Install into `D:\scantailor-advanced` directory
    ```
    choco install scantailor-advanced --params "/InstallationPath:D:\scantailor-advanced"
    ```