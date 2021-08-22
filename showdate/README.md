# showdate
Command line utility to display date/time.

The date/time to be displayed can be either the current date/time (default), or the creation or modification date/time of a file or directory.

By default the local time is shown, but it's also possible to show UTC time (Coordinated Universal Time).

The format used can be specified, using the same format string as the `strftime()` C function.


## Usage
```
$ showdate.exe --help
Usage: showdate [-hvu] [-f fmt] [-c file] [-m file] [--add-days=n] [--sub-days=n] [--add-hours=n] [--sub-hours=n] [--add-minutes=n] [--sub-minutes=n] [--add-seconds=n] [--sub-seconds=n]
Display date/time in the specified format
  -h, --help          print this help and exit
  -v, --version       print version information and exit
  -f, --format=fmt    strftime() date/time format, default: "%Y-%m-%d %H:%M:%S"
  -u, --utc           show UTC time instead of local time
  -c, --created=file  use file creation date/time
  -m, --modified=file use file modification date/time
  --add-days=n        add n days to date/time
  --sub-days=n        subtract n days from date/time
  --add-hours=n       add n hours to date/time
  --sub-hours=n       subtract n hours from date/time
  --add-minutes=n     add n minutes to date/time
  --sub-minutes=n     subtract n minutes from date/time
  --add-seconds=n     add n seconds to date/time
  --sub-seconds=n     subtract n seconds from date/time
```