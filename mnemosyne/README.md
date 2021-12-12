

﻿# The Mnemosyne Project
The Mnemosyne Project consists of two parts:
* A free flash-card tool which optimizes your learning process.
* A research project into the nature of long-term memory.

Mnemosyne aims to be a user-friendly flash card program, with a clean, deceptively simple interface that does not require you to wrap your head around complicated concepts before you can start using it. At the same time, under the hood it is very powerful, and its architecture allows infinite extensibility and customisibility through plugins and a scripting API, for the benefit of power users.

![](https://cdn.jsdelivr.net/gh/jakublevy/chocopkgs/mnemosyne/review.png)

## Features
* https://mnemosyne-proj.org/features

## Installation Parameters
* `/InstallDir:` - where to install the binaries
    - Default value: 
        - `"${env:ProgramFiles(x86)}\Mnemosyne"` on 64-bit Windows
        - `"$env:ProgramFiles\Mnemosyne"` on 32-bit Windows

### Examples
* Install into `D:\mnemosyne` directory
    ```
    choco install mnemosyne --params "/InstallDir:D:\mnemosyne"
    ```