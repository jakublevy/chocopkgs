# csvtk
`csvtk` is a cross-platform, efficient and practical CSV/TSV toolkit.

## Features
- **Cross-platform** (Linux/Windows/Mac OS X/OpenBSD/FreeBSD)
- **Light weight and out-of-the-box, no dependencies, no compilation, no configuration**
- **Fast**,  **multiple-CPUs supported** (some commands)
- **Practical functions provided by N subcommands**
- **Support STDIN and gziped input/output file, easy being used in pipe**
- Most of the subcommands support ***unselecting fields*** and ***fuzzy fields***, e.g. `-f "-id,-name"` for all fields except "id" and "name", `-F -f "a.*"` for all fields with prefix "a.".
- **Support some common plots** (see [usage](http://bioinf.shenwei.me/csvtk/usage/#plot))

### For more information about csvtk see [the official README.md](https://github.com/shenwei356/csvtk/blob/master/README.md).