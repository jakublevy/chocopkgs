# PDFCrack
A Password Recovery Tool for PDF-files

fork from http://pdfcrack.sourceforge.net (0.19)

PDFCrack is a GNU/Linux (other POSIX-compatible systems should work too) tool for recovering passwords and content from PDF-files. It is small, command line driven without external dependencies. The application is Open Source (GPL).

## Features
* Supports the standard security handler (revision 2, 3 and 4) on all known PDF-versions
* Supports cracking both owner and user passwords
* Both wordlists and brute forcing the password is supported
* Simple permutations (currently only trying first character as Upper Case)
* Save/Load a running job
* Simple benchmarking
* Optimize search for owner-password when user-password is known

## Usage
```
Usage: pdfcrack.exe -f filename [OPTIONS]
OPTIONS:
-b, --bench             perform benchmark and exit
-c, --charset=STRING    Use the characters in STRING as charset
-w, --wordlist=FILE     Use FILE as source of passwords to try
-n, --minpw=INTEGER     Skip trying passwords shorter than this
-m, --maxpw=INTEGER     Stop when reaching this passwordlength
-l, --loadState=FILE    Continue from the state saved in FILENAME
-o, --owner             Work with the ownerpassword
-u, --user              Work with the userpassword (default)
-p, --password=STRING   Give userpassword to speed up breaking
                        ownerpassword (implies -o)
-q, --quiet             Run quietly
-s, --permutate         Try permutating the passwords (currently only
                        supports switching first character to uppercase)
-v, --version           Print version and exit
```