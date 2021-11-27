# xxd
xxd creates a hex dump of a given file or standard input. It can also convert a hex dump back to its original binary form. Like [uuencode](https://linux.die.net/man/1/uuencode)(1) and [uudecode](https://linux.die.net/man/1/uudecode)(1) it allows the transmission of binary data in a 'mail-safe' ASCII representation, but has the advantage of decoding to standard output. Moreover, it can be used to perform binary file patching. 

## Examples
Print everything but the first three lines (hex 0x30 bytes) of file.
```
$ xxd -s 0x30 file
```
Print 3 lines (hex 0x30 bytes) from the end of file.
```
$ xxd -s -0x30 file
```

Print 120 bytes as continuous hexdump with 20 octets per line.
```
$ xxd -l 120 -ps -c 20 xxd.1
2e54482058584420312022417567757374203139
39362220224d616e75616c207061676520666f72
20787864220a2e5c220a2e5c222032317374204d
617920313939360a2e5c22204d616e2070616765
20617574686f723a0a2e5c2220202020546f6e79
204e7567656e74203c746f6e79407363746e7567
```