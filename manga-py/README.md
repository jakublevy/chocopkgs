# manga-py
* Universal manga downloader.
* Approximately 200+ providers are available now.

## Supported resources
* https://manga-py.com/manga-py/#resources-list

## Examples
```
# download to ".\Manga\manga-name-here" directory
manga-py "http://manga-url-here/manga-name"

# download to ".\Manga\Manga Name" directory
manga-py "http://manga-url-here/manga-name" --name "Manga Name"

# or download to "C:\manga\destination\path\manga-name-here" directory
manga-py "http://manga-url-here/manga-name" -d "C:\manga\destination\path"

# skip 3 volumes
manga-py --skip-volumes 3 "http://manga-url-here/manga-name"

# skip 3 volumes and download 2 volumes
manga-py --skip-volumes 3 --max-volumes 2 "http://manga-url-here/manga-name"

# reverse volumes downloading (24 -> 1)
manga-py --reverse-downloading "http://manga-url-here/manga-name"

# disable progressbar
manga-py --no-progress "http://manga-url-here/manga-name"
```

## Usage
```
manga-py -h  # shows help
```