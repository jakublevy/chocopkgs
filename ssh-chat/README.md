

# ssh-chat
Custom SSH server written in Go. Instead of a shell, you get a chat prompt.

## Demo
https://github.com/shazow/ssh-chat#demo

## Usage
```
$ ssh-chat -h
Usage:
  ssh-chat [OPTIONS]

Application Options:
      /admin:              File of public keys who are admins.
      /bind:               Host and port to listen on. (default: 0.0.0.0:2022)
  /i, /identity:           Private key to identify server with. (default:
                           ~/.ssh/id_rsa)
      /log:                Write chat log to this file.
      /motd:               Optional Message of the Day file.
      /pprof:              Enable pprof http server for profiling.
  /v, /verbose             Show verbose logging.
      /version             Print version and exit.
      /whitelist:          Optional file of public keys who are allowed to
                           connect.
      /unsafe-passphrase:  Require an interactive passphrase to connect.
                           Whitelist feature is more secure.

Help Options:
  /?                       Show this help message
  /h, /help                Show this help message

There are hidden options and easter eggs in ssh-chat. The source code is a good
place to start looking. Some useful links:

* Project Repository:
  https://github.com/shazow/ssh-chat
* Project Wiki FAQ:
  https://github.com/shazow/ssh-chat/wiki/FAQ
```

## FAQ
The FAQs can be found on the project's [Wiki page](https://github.com/shazow/ssh-chat/wiki/FAQ). Feel free to submit more questions to be answered and added to the page.