

# ddh, Generic hasher
ddh is a generic hasher available cross-platform (Windows, macOS, Linux, BSDs) and comes with more features than built-in OS utilities.

## Usage
```
Usage: ddh [options...|--autocheck] [files...|--stdin]

Options
    --            Stop processing options.
-f, --file        Input mode: Regular file (default).
-b, --binary      File: Set binary mode (default).
-t, --text        File: Set text mode.
-m, --mmfile      Input mode: Memory-map file.
-a, --arg         Input mode: Command-line argument is text data (UTF-8).
    --stdin       Input mode: Standard input (stdin)
-c, --check       Check hashes list in this file.
    --autocheck   Automatically determine hash type and process list.
-C, --compare     Compares all file entries.
-A, --against     Compare files against hash.
    --hashes      List supported hashes.
-B, --buffersize  Set buffer size, affects file/mmfile/stdin (default=4K).
    --shallow     Depth: Same directory (default).
-r, --depth       Depth: Deepest directories first.
    --breath      Depth: Sub directories first.
    --follow      Links: Follow symbolic links (default).
    --nofollow    Links: Do not follow symbolic links.
    --tag         Create or read BSD-style hashes.
    --sri         Create or read SRI-style hashes.
    --plain       Create or read plain hashes.
    --key         Binary key file for BLAKE2 hashes.
    --seed        Seed literal argument for Murmurhash3 hashes.
    --version     Show version page and quit.
    --ver         Show version and quit.
    --license     Show license page and quit.
-h, --help        This help information.

This program has actual coffee-making abilities.
```