# LPSolve IDE
The LPSolve IDE (Integrated Development Interface) is a very user friendly Windows interface to the lpsolve API. All functionality of lpsolve can be accessed via a graphical and very user friendly application. 

## Here is a list of some of the features of the IDE:
* Everything is graphical and mouse controled
* Enter your lp model in all supported formats and even via an XLI interface (See External Language Interfaces)
* Convert your lp model from any supported format to another supported format and even via an XLI interface (See External Language Interfaces)
* Very user friendly editor to enter/change the model with syntax highlight.
* Syntax checking of the model
* Solve the model
* See the results in grids
* Control every possible lpsolve option (tolerances, presolve, scaling, ...)
* View the matrix in grids
* Export model to HTML, RTF, LaTeX output
* Export matrix to CSV, HTML, RTF output
* Export results to CSV, HTML, RTF output
* Show statistics about the model.
* ...

![](https://cdn.jsdelivr.net/gh/jakublevy/chocopkgs/lpsolve-ide/IDE.png)


## Parameters
* `/DIR:` - where to install the binaries
    - Default value: 
        - `"${env:ProgramFiles(x86)}\LPSolve IDE"` on 64-bit Windows
        - `"$env:ProgramFiles\LPSolve IDE"` on 32-bit Windows
* `/Tasks:` - passes values to `/MERGETASKS=""` (all tasks are enabled by default)
    - desktopicon
        - Create a desktop icon
    - quicklaunchicon
        - Create a Quick Launch icon
    - LPFile
        - Associate .lp
    - MPSFile
        - Associate .mps
    - MathProgFile
        - Associate .mod
    - ZIMPLFile
        - Associate .zpl
    - CPLEXFile
        - Associate .lpt
    - LINDOFile
        - Associate .ltx
    - XpressFile
        - Associate .lpx
    - DIMACSFile
        - Associate .net

### Examples
* Install into `D:\lpsolve-ide` directory
    ```
    choco install lpsolve-ide --params "/DIR:D:\lpsolve-ide"
    ```
* Install, do not create anything and do not associate anything
   ```
   choco install lpsolve-ide --params "/Tasks:!desktopicon !quicklaunchicon !LPFile !MPSFile !MathProgFile !ZIMPLFile !CPLEXFile !LINDOFILE !XpressFile !DIMACSFile"
   ```
* Install and do not create Desktop icon and Quick Launch icon
    ```
    choco install lpsolve-ide --params "/Tasks:!desktopicon !quicklaunchicon"
    ```