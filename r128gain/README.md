

# r128gain
Fast audio loudness scanner &amp; tagger.

r128gain is a multi platform command line tool to scan your audio files and tag them with loudness metadata (ReplayGain v2 or Opus R128 gain format), to allow playback of several tracks or albums at a similar loudness level. r128gain can also be used as a Python module from other Python projects to scan and/or tag audio files.

## Features
* Supports all common audio file formats (MP3, AAC, Vorbis, Opus, FLAC, WavPack...) and tag formats (ID3, Vorbis comments, MP4, APEv2...)
* Writes tags compatible with music players reading track/album gain metadata
* Supports new R128_XXX_GAIN tag format for Opus files (very few scanners write this tag, although it is defined in the [Opus standard](https://tools.ietf.org/html/rfc7845#section-5.2))
* Supports writing gain to the [Opus *output gain* header](https://tools.ietf.org/html/rfc7845#page-15) **(experimental)**
* Uses threading to optimally use processor cores resulting in very fast processing

## Usage
```
$ r128gain.exe --help
usage: r128gain.exe [-h] [-a] [-r] [-s] [-o] [-p [MTIME_SECOND_OFFSET]]
                    [-c THREAD_COUNT] [-f FFMPEG_PATH] [-d]
                    [-v {warning,normal,debug}]
                    path [path ...]

r128gain v1.0.3. Scan audio files and tag them with ReplayGain/R128 loudness
metadata.

positional arguments:
  path                  Audio file paths, or directory paths for recursive
                        mode

optional arguments:
  -h, --help            show this help message and exit
  -a, --album-gain      Enable album gain (default: False)
  -r, --recursive       Enable recursive mode: process audio files in
                        directories and subdirectories. If album gain is
                        enabled, all files in a directory are considered as
                        part of the same album. (default: False)
  -s, --skip-tagged     Do not scan &amp; tag files already having loudness tags.
                        Warning: only enable if you are sure of the validity
                        of the existing tags, as it can cause volume
                        differences if existing tags are incorrect or coming
                        from a old RGv1 tagger. (default: False)
  -o, --opus-output-gain
                        For Opus files, write album or track gain in the
                        'output gain' Opus header (see
                        https://tools.ietf.org/html/rfc7845#page-15). This
                        gain is mandatory to apply for all Opus decoders so
                        this should improve compatibility with players not
                        supporting the R128 tags. Warning: This is
                        EXPERIMENTAL, only use if you fully understand the
                        implications. (default: False)
  -p [MTIME_SECOND_OFFSET], --preserve-times [MTIME_SECOND_OFFSET]
                        Preserve modification times of tagged files,
                        optionally adding MTIME_SECOND_OFFSET seconds.
                        (default: None)
  -c THREAD_COUNT, --thread-count THREAD_COUNT
                        Maximum number of tracks to scan in parallel. If not
                        specified, autodetect CPU count (default: None)
  -f FFMPEG_PATH, --ffmpeg-path FFMPEG_PATH
                        Full file path of ffmpeg executable (only needed if
                        not in PATH). If not specified, autodetect (default:
                        .\ffmpeg.EXE)
  -d, --dry-run         Do not write any tags, only show scan results
                        (default: False)
  -v {warning,normal,debug}, --verbosity {warning,normal,debug}
                        Level of logging output (default: normal)
```

### For more information about r128gain see [README.md](https://github.com/desbma/r128gain/blob/master/README.md).