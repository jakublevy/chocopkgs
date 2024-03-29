

# mairix
mairix is a program for indexing and searching email messages stored in Maildir, MH, MMDF or mbox folders.
* Indexing is fast.  It runs incrementally on new messages - any particular message only gets scanned once in the lifetime of the index file.
* The search mode populates a "virtual" folder with symlinks(*) which point to the real messages.  This folder can be opened as usual in your mail program.
* The search mode is very fast.
* Indexing and searching works on the basis of words.  The index file tabulates which words occur in which parts (particular headers + body) of which messages.
  
The program is a very useful complement to mail programs like mutt (http://www.mutt.org/, which supports Maildir, MH and mbox folders) and Sylpheed (which supports MH folders).