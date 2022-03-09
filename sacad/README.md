

# SACAD
SACAD is a multi platform command line tool to download album covers without manual intervention, ideal for integration in scripts, audio players, etc.

## Features
- Can target specific image size, and find results for high resolution covers
- Support JPEG and PNG formats
- Customizable output: save image along with the audio files / in a different directory named by artist/album / embed cover in audio files...
- Currently support the following cover sources:
  - Amazon CD (.com, .ca, .cn, .fr, .de, .co.jp and .co.uk variants)
  - Amazon digital music
  - ~~CoverLib~~ (site is down)
  - Deezer
  - Google Images
  - Last.fm
- Smart sorting algorithm to select THE best cover for a given query, using several factors: source reliability, image format, image size, image similarity with reference cover, etc.
- Automatically crunch images with optipng or jpegoptim (can save 30% of filesize without any loss of quality, great for portable players)
- Cache search results locally for faster future search
- Do everything to avoid getting blocked by the sources: hide user-agent and automatically take care of rate limiting
- Automatically convert/resize image if needed
- Multiplatform (Windows/Mac/Linux)

SACAD is designed to be robust and be executed in batch of thousands of queries:

- HTML parsing is done without regex but with the LXML library, which is faster, and more robust to page changes
- When the size of an image reported by a source is not reliable (ie. Google Images), automatically download the first KB of the file to get its real size from the file header
- Process several queries simultaneously (using [asyncio](https://docs.python.org/3/library/asyncio.html)), to speed up processing
- Automatically reuse TCP connections (HTTP Keep-Alive), for better performance
- Automatically retry failed HTTP requests
- Music library scan supports all common audio formats (MP3, AAC, Vorbis, FLAC..)
- Cover sources page or API changes are quickly detected, thanks to high test coverage, and SACAD is quickly updated accordingly

## Command line usage
Two tools are provided: `sacad` to search and download one cover, and `sacad_r` to scan a music library and download all missing covers.

Run `sacad -h` / `sacad_r -h` to get full command line reference.