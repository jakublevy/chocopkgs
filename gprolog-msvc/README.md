**NOTE:** This package installs a version compiled with MSVC. The version compiled with MinGW is available as a [gprolog-mingw](https://community.chocolatey.org/packages/gprolog-mingw) package.

**NOTE:** The following text is for the most part an excerpt from [the official website](http://www.gprolog.org).

# GNU Prolog

GNU Prolog is a free Prolog compiler with constraint solving over finite domains developed by [Daniel Diaz](https://cri-dist.univ-paris1.fr/diaz).

GNU Prolog accepts Prolog+constraint programs and produces native binaries (like gcc does from a C source). The obtained executable is then stand-alone. The size of this executable can be quite small since GNU Prolog can avoid to link the code of most unused built-in predicates. The performances of GNU Prolog are very encouraging (comparable to commercial systems).

Beside the native-code compilation, GNU Prolog offers a classical interactive interpreter (top-level) with a debugger.

The Prolog part conforms to the ISO standard for Prolog with many extensions very useful in practice (global variables, OS interface, sockets,...).

GNU Prolog also includes an efficient constraint solver over Finite Domains (FD). This opens contraint logic programming to the user combining the power of constraint programming to the declarativity of logic programming.

## Parameters
* `/InstallationPath:` - where to install the binaries
    - Default value: `"$env:SystemDrive\GNU-Prolog"`
* `/CreateDesktopIcon` - creates a desktop icon
    - Not created by default
* `/AssocPl` - associates GNU Prolog as the default app for *.pl files
    - Not associated by default
* `/AssocPro` - associates GNU Prolog as the default app for *.pro files
    - Not associated by default
* `/AssocProlog` - associates GNU Prolog as the default app for *.prolog files
    - Not associated by default

### Examples
* Install into `D:\gprolog` directory
    ```
    choco install gprolog-msvc --params "/InstallationPath:"D:\gprolog""
    ```
* Install with all file associations
    ```
    choco install gprolog-msvc --params "/AssocPl /AssocPro /AssocProlog"
    ```
* Install and create desktop icon
   ```
   choco install gprolog-msvc --params "/CreateDesktopIcon"
   ```
   