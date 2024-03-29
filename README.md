# Home assistant add-ons of ElVit

## About

My home assistant addon repository.

## Installation

Adding this add-ons repository to your Home Assistant instance is pretty easy.
Follow [the official instructions][instructions] on the website of Home Assistant, and use the following URL:

```
https://github.com/elvit/hassio-addons
```

## Available addons

[//]: # "ADDONLIST_START"

### &#10003; [LFTP sync](lftp/)

- A simple sync tool that uses the lftp command-line program.  
  Allows to up- or download almost any file from/to a remote share.

### &#10003; [Rsync](rsync/)

- Sync directories by using the [rsync](https://rsync.samba.org/) daemon.

### &#10003; [Samba server](samba/)

- A simple samba (smb) server with modifiable configuration file.

### &#10003; [Traefik](traefik/)

- A  modern HTTP reverse proxy and load balancer that makes deploying microservices easy.

### &#10003; [WebDAV server](webdav/)

- A tiny WebDAV server using [lighttpd](https://www.lighttpd.net/).  

[//]: # "ADDONLIST_END"

[instructions]: https://home-assistant.io/hassio/installing_third_party_addons
