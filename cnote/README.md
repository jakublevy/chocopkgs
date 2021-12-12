

# cnote
`cnote` is a cross-platform command-line note app suitable for **rapidly taking and getting note** of plain text of tens of words.

It supports **backup** and **restore**, you can also **import** notes from backups of others.

`cnote` stores all data in a embedded database [goleveldb](https://github.com/syndtr/goleveldb), an implementation of the LevelDB key/value database in the Go programming language. The path of database files is `"$env:UserProfile\.cnote"` on Windows.

## Usage
```
$ cnote.exe --help
NAME:
   cnote - A command line note app. https://github.com/shenwei356/cnote

USAGE:
   cnote [global options] command [command options] [arguments...]

VERSION:
   1.1 (2014-07-20)

COMMANDS:
   new          Create a new note
   del          Delete a note
   use          Select a note
   list, ls     List all notes
   add          add a note item
   rm           Remove a note item
   tag, t       List items by tags
   search, s    Search for
   dump         Dump whole database, for backup or transfer
   wipe         Attention! Wipe whole database
   restore      Wipe whole database, and restore from dumpped file
   import       Import note items from dumpped data
   help, h      Shows a list of commands or help for one command

GLOBAL OPTIONS:
   --help, -h           show help
   --version, -v        print the version
```

### For more information about `cnote` see [the official README.md](https://github.com/shenwei356/cnote/blob/master/README.md).