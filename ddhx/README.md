# ddhx, Hexadecimal File Viewer
ddhx is a quick and dirty TUI hexadecimal file viewer.

It also supports dumping.

## Usage
```
$ ddhx -h
ddhx - Interactive hexadecimal file viewer
  Usage: ddhx [OPTIONS] FILE

-w, --width        Set column width in bytes ('a'=automatic,default=16)
-o, --offset       Set offset mode (decimal, hex, or octal)
-C, --defaultchar  Set default character for non-ascii characters
-m, --mmfile       Force mmfile mode, recommended for large files
-f, --file         Force file mode
    --stdin        Force standard input mode
-s, --seek         Seek at position
-D, --dump         Non-interactive dump
-l, --length       Dump: Length of data to read
    --version      Print the version screen and exit
    --ver          Print only the version and exit
-h, --help         Print this help screen and exit
```