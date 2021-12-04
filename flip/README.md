# flip
The program converts line endings of text files between MS-DOS and UNIX formats. It detects binary files in a nearly foolproof way and leaves them alone unless you override this. It will also leave files alone that are already in the right format and preserves file timestamps. User interrupts are handled gracefully and no garbage or corrupted files left behind.

The program does not convert files to a different character set, and it can not handle old Apple Macintosh line endings that use CR only.


## Usage
```
$ flip -h
File interchange program flip version 1.19.  Copyright 1989 Rahul Dhesi,
All rights reserved.  Both noncommercial and commercial copying, use, and
creation of derivative works are permitted in accordance with the
requirements of the GNU license.  This program does newline conversions.

   Usage:     flip -umhvtsbz file ...

One of -u, -m, or -h is required;  others are optional.  See user manual.

   -u     convert to **IX format (CR LF → LF, lone CR or LF unchanged,
          trailing control Z removed, embedded control Z unchanged)
   -m     convert to MS-DOS format (lone LF → CR LF, lone CR unchanged)
   -h     give this help message
   -v     be verbose, print filenames as they are processed
   -t     touch files (don't preserve timestamps)
   -s     strip high bit
   -b     convert binary files too (else binary files are left unchanged)
   -z     truncate file at first control Z encountered

May be invoked as "toix" (same as "flip -u") or "toms" (same as "flip -m").
```