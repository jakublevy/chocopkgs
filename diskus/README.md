

# diskus
A minimal, fast alternative to `du -sh`.

`diskus` is a very simple program that computes the total size of the current directory. It is a parallelized version of `du -sh`. On my 8-core laptop, it is about ten times faster than `du` with a cold disk cache and more than three times faster with a warm disk cache.

```
$ diskus
9.59 GB (9,587,408,896 bytes)
```

## Windows caveats

Windows-internal tools such as Powershell, Explorer or `dir` are not respecting hardlinks or
junction points when determining the size of a directory. `diskus` does the same and counts
such entries multiple times (on Unix systems, multiple hardlinks to a single file are counted
just once).