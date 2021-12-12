

# Spin
Spin is a widely used open-source software verification tool. The tool can be used for the formal verification of multi-threaded software applications. The tool was developed at [Bell Labs](https://www.bell-labs.com) in the Unix group of the Computing Sciences Research Center, starting in 1980, and has been available freely since 1991. Spin continues to evolve to keep pace with new developments in the field. In April 2002 the tool was awarded the ACM [System Software Award](https://awards.acm.org/software_system).	

## Main usage
Spin can be used in four main modes:
* as a simulator, allowing for rapid prototyping with a random, guided, or interactive simulations
* as an exhaustive verifier, capable of rigorously proving the validity of user specified correctness requirements (using partial order reduction theory to optimize the search)
* as proof approximation system that can validate even very large system models with maximal coverage of the state space.
* as a driver for swarm verification (a new form of swarm computing that can exploit cloud networks of arbitrary size), which can make optimal use of large numbers of available compute cores to leverage parallelism and search diversification techniques, which increases the chance of locating defects in very large verification models.


All Spin software is written in ISO-standard C, and is portable across all versions of Unix, Linux, cygwin, Plan9, Inferno, Solaris, Mac, and Windows.

## Dependencies and related software
To run Spin, you need a working C-compiler and a C-preprocessor, because Spin generates its model checking software as C-source files that require compilation before a verification can be performed. This guarantees fast model checking, because each model checker can be optimized to the specific model being checked. For more information see [Related software](http://spinroot.com/spin/Man/README.html#S3).

## Installation Parameters
* `/AddiSpinToStartMenu:` - adds iSpin shortcut to Start menu (for all users or for the current user only)
    - Supported values: `allusers`, `curruser`
    - No shortcut added to Start menu by default
* `/CreateiSpinDesktopIcon` - creates a desktop shortcut for iSpin
    - Not created by default

### Examples
* Install and add iSpin shortcut to Start menu for all users
    ```
    choco install spin --params "/AddiSpinToStartMenu:allusers"
    ```
* Install, create iSpin desktop shortcut and add iSpin shortcut to Start menu for the current user
    ```
    choco install spin --params "'/AddiSpinToStartMenu:curruser /CreateiSpinDesktopIcon'"
    ```