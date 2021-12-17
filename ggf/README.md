

# ggf - Windows disk information tool
A small, lazily-written, df-like, Windows disk information tool.

## Examples
```
ggf
DRIVE  TYPE            USED       FREE      TOTAL  TYPE    NAME
C:     Fixed       207.66 G    24.59 G   232.25 G  NTFS    OS
D:     Fixed       813.38 G   118.13 G   931.51 G  NTFS    Data
G:     Optical
Z:     Network       6.48 G     8.16 G    14.64 G  FUSE-SSHFS
```

```
ggf -P
DRIVE  USAGE
C:     [============================================================                      ] 72.7%
D:     [===================================================                               ] 62.0%
E:     [==========================                                                        ] 32.9%
G:
K:     [====================================================================              ] 81.9%
```

```
ggf -M
DRIVE  SERIAL     MAX PATH
C:     ACBB-235D       255
D:     666C-A820       255
G:
Y:     A9EE-3156       255
Z:     0090-0458       255
```

## Usage
```
ggf -h
Get disk(s) information.
  Usage: ggf [OPTIONS] [DRIVE]
         ggf {-h|-v|-?}

By default, view disk usage by size.

OPTIONS
-P      View usage by progress-bar style
-F      View features
-M      View misc. features (serial, MAX_PATH)
-b      Use base10 size formatting
-n      Remove header
```