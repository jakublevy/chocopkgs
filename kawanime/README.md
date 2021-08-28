# KawAnime
**Disclaimer**: KawAnime is built for otaku/anime-fans. The software will contain images and sounds sourced from anime. Do not try if you're not prepared.

## Features
* Manage your anime life with a single software.
* Get updated on anime releases as soon as they are subbed (or not).
* Download or Stream your torrents easily (in-app torrent client included!).
* Magnet links for all episodes can be generated through the Downloader.
* Get anime information, news, and seasonal information from your preferred anime information source ([Anilist](https://anilist.co), [Kitsu.io](https://Kitsu.io), [MAL](https://myanimelist.net)).
* Manage your anime files (watch and delete on click).
* Manage local watch lists as well as those from your preferred provider ([Anilist](https://anilist.co), [Kitsu.io](https://Kitsu.io), [MAL](https://myanimelist.net)).
* Auto track entry progress on [Anilist](https://anilist.co) and [Kitsu.io](https://Kitsu.io).
* Keep track of what you watched with the History.
* Easily binge watch your local anime or while streaming.

Feel free to check the official website for [a demo of all the available features](https://kawanime.com/#features).


## Installation Parameters
* `/InstallForAllUsers:` - should KawAnime be installed for all users
    - Supported values `yes`, `no`
    - Default value: `yes`
* `/InstallDir:` - where to install the binaries
    - Default value: `$env:ProgramFiles\KawAnime`

### Examples
* Install into `C:\Users\Joe\kawanime` for the current user (Joe) only
    ```
    choco install kawanime --params "'/InstallForAllUsers:no /InstallDir:C:\Users\Joe\kawanime'"
    ```