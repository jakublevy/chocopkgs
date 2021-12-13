

# GetUserInfo
Command line tool to extract user info from a domain or computer.

## Usage
```
GetUserInfo [(domain)(\\servername)\]userid [/p]

   domain          Domain to execute command against
   server          Server to execute command against
   userid          Userid to get info for.
   /p              Displays primary group info.

   If domain/server not specifed uses local machine
   If . specified for userid, enumerate all local/global accounts

Ex:
   getuserinfo .
       Enumerates accounts on local machine

   getuserinfo \\server\.
       Enumerates accounts on machine named server

   getuserinfo domain\.
       Enumerates accounts on domain named domain

   getuserinfo username
       Displays info for local userid named username

   getuserinfo \\server\username
       Displays info for userid on machine server named username

   getuserinfo domain\username
       Displays info for userid on domain named domain for user named username
```