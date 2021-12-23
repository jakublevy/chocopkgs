

# ddh, Generic hasher
ddh is a generic hasher available cross-platform (Windows, macOS, Linux, BSDs) and comes with more features than built-in OS utilities.

## Usage
```
$ ddh -h
Usage: ddh command [options...] [files...] [-]

Commands
list      List all supported hashes and checksums.
help      This help page and exit.
ver       Only show version number and exit.
version   Show version page and exit.

Options
--                Stop processing options.
-                 Input mode: Standard input (stdin).
-F, --file        Input mode: Regular file (default).
-b, --binary      File: Set binary mode (default).
-t, --text        File: Set text mode.
-M, --mmfile      Input mode: Memory-map file.
-a, --arg         Input mode: Command-line argument is text data (UTF-8).
-c, --check       Check hashes list in this file.
-C, --chunk       Set buffer size, affects file/mmfile/stdin (default=64K).
    --shallow     Depth: Same directory (default).
-s, --depth       Depth: Deepest directories first.
    --breadth     Depth: Sub directories first.
    --follow      Links: Follow symbolic links (default).
    --nofollow    Links: Do not follow symbolic links.
    --tag         Create or read BSD-style hashes.
    --sri         Create or read SRI-style hashes.
    --version     Show version page and quit.
    --ver         Show version and quit.
    --license     Show license page and quit.
-h, --help        This help information.
This program has actual coffee-making abilities.
```