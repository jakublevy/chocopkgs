

# cheat
`cheat` allows you to create and view interactive cheatsheets on the command-line. It was designed to help remind UNIX system administrators of options for commands that they use frequently, but not frequently enough to remember.

Use cheat with [cheatsheets](https://github.com/cheat/cheatsheets).

## Example
The next time you're forced to disarm a nuclear weapon without consulting Google, you may run:
```
cheat tar
```
You will be presented with a cheatsheet resembling the following:
```
# To extract an uncompressed archive:
tar -xvf '/path/to/foo.tar'

# To extract a .gz archive:
tar -xzvf '/path/to/foo.tgz'

# To create a .gz archive:
tar -czvf '/path/to/foo.tgz' '/path/to/foo/'

# To extract a .bz2 archive:
tar -xjvf '/path/to/foo.tgz'

# To create a .bz2 archive:
tar -cjvf '/path/to/foo.tgz' '/path/to/foo/'
```

### For more information about cheat see [README.md](https://github.com/cheat/cheat/blob/master/README.md).