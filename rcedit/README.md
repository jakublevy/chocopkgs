

# rcedit
Command line tool to edit resources of exe file on Windows.

## Examples
Show help:
```
$ rcedit -h
```
Set version string:
```
$ rcedit "path-to-exe-or-dll" --set-version-string "Comments" "This is an exe"
```
Set icon:
```
$ rcedit "path-to-exe-or-dll" --set-icon "path-to-ico"
```
Set application manifest:
```
$ rcedit "path-to-exe-or-dll" --application-manifest ./path/to/manifest/file
```
Get version string:
```
$ rcedit "path-to-exe-or-dll" --get-version-string "property"
```

### For more information about rcedit see [README.md#Docs](https://github.com/electron/rcedit#docs).