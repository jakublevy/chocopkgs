

﻿# Spotify TUI
A Spotify client for the terminal written in Rust.

## Connecting to Spotify’s API
`spotify-tui` needs to connect to Spotify’s API in order to find music by name, play tracks etc.

Instructions on how to set this up will be shown when you first run the app.

## Usage
The binary is named `spt`.

Running `spt` with no arguments will bring up the UI. Press `?` to bring up a help menu that shows currently implemented key events and their actions. There is also a CLI that is able to do most of the stuff the UI does. Use `spt --help` to learn more.

Here are some example to get you excited.
```
spt --completions zsh # Prints shell completions for zsh to stdout (bash, power-shell and more are supported)

spt play --name "Your Playlist" --playlist --random # Plays a random song from "Your Playlist"
spt play --name "A cool song" --track # Plays 'A cool song'

spt playback --like --shuffle # Likes the current song and toggles shuffle mode
spt playback --toggle # Plays/pauses the current playback

spt list --liked --limit 50 # See your liked songs (50 is the max limit)

# Looks for 'An even cooler song' and gives you the '{name} from {album}' of up to 30 matches
spt search "An even cooler song" --tracks --format "%t from %b" --limit 30

```

## Configuration
A configuration file is located at `"$env:userprofile\.config\spotify-tui\config.yml"`(not to be confused with client.yml which handles Spotify authentication)

## Limitations
This app uses the Web API from Spotify, which doesn't handle streaming itself. So you'll need either an official Spotify client opened or some other lighter weight alternative.

If you want to play tracks, Spotify requires that you have a Premium account.

### For more information about Spotify TUI see the official [README.md](https://github.com/Rigellute/spotify-tui/blob/master/README.md).