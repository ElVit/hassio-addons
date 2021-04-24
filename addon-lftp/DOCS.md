# Home Assistant Add-on: LFTP Sync

A simple but powerfull addon that uses the lftp client.  
lftp is a command-line program client for several file transfer protocols.  
lftp can transfer files via FTP, FTPS, HTTP, HTTPS, FISH, SFTP, BitTorrent, and FTP over HTTP proxy.  

This addon provides at first only some simple features of lftp like up or downloading files over ftp.  
But advanced users may also use a lftp script file which allows them to use the full potential of lftp.  

## Installation

The installation of this add-on is pretty straightforward and not different in comparison to installing any other Home Assistant add-on.  

1. [Add my Hass.io add-ons repository][repository] to your home assistant instance.  
1. Search for the "LFTP Sync" add-on in the Supervisor add-on store and install it.  
1. Set the add-on options to your preferences  
1. Click the `Save` button to store your configuration.  
1. Start the "LFTP Sync" add-on  
1. Check the logs of the "LFTP Sync" add-on to see if everything went well.  

## Configuration

**Note**: _Remember to restart the add-on when the configuration is changed._

Example add-on configuration:  

```yaml
host: 'ftp://192.168.1.1'
username: admin
password: password
remote_folder: /remoteDir
local_folder: /localDir
direction: download
parallel: many_small_files
copy_hidden_files: false
auto_confirm: true
no_certificate_check: true
delete: true
verbose: true
continue: true
script_file: /config/lftpscripts/my_script.lftp
```

### Option: `host`

The host name or ip address to the remote site.  

### Option: `username`

The username of the remote site. used for authentication.  

### Option: `password`

The password of the remote site. used for authentication.  

### Option: `local_folder`

The directory on your home assistant machine.  
The path shall start with /config, /ssl, /addons, /share, /backup or /media.  

### Option: `remote_folder`

The directory on your remote server which you are connected over ftp.  

### Option: `direction`

The sync direction may be 'download' or 'upload'.  
- download copies files from the remote folder to the local folder  
- upload copies files from the local folder to the remote folder  

### Option: `parallel`

If this option is set to 'many_small_files' or 'few_large_files', multiple files will be copied at the same time.  
This may accelerate your sync job but be aware that it may also slow down your machine while the sync job is running.  

### Option: `copy_hidden_files`

When true, lftp will also copy hidden files and folders  
Hidden files/folder start always with a dot e.g. ".htaccess".  

### Option: `auto_confirm`

When true, lftp answers "yes" to all ssh questions, in particular to the question about a new host key. Otherwise it answers "no".  

### Option: `no_certificate_check`

When true, then no ssl certificate check will be done.  

### Option: `delete`

When true, lftp will delete files that are not present at the source directory.  

### Option: `verbose`

When true, lftp will write a diagnostic message for every processed file.  

### Option: `continue`

When true, lftp will continue a mirror job if possible.  
That means that during a sync jobs already downloaded files will not be re-downladed.  

### Option: `script_file`

_!!! If this option contains a path that leads to a valid lftp script file, it will ignore all above options !!!_  
With this option you may write your own lftp script file and let it execute by this addon.  

Here an example:  
```
set sftp:auto-confirm yes
set ssl:verify-certificate no
open ftp://192.168.1.1
user admin password
lcd /share/mydir1
cd /remote/mydir2
mirror --continue --delete --verbose --parallel=100
bye
```

In combination with a home assistant automation you may turn this addon in a powerfull backup solution.  

## Changelog & Releases

Releases are based on [Semantic Versioning][semver], and use the format of `MAJOR.MINOR.PATCH`.  
In a nutshell, the version will be incremented based on the following:  

- `MAJOR`: Incompatible or major changes.  
- `MINOR`: Backwards-compatible new features and enhancements.  
- `PATCH`: Backwards-compatible bugfixes and package updates.  

## Support

Got questions?

You can simply [open an issue here][issue] GitHub.  

## Authors & contributors

The original setup of this repository is by [ElVit][elvit].  


[lftp]: https://lftp.yar.ru/
[elvit]: https://github.com/elvit
[issue]: https://github.com/elvit/hassio-addons/issues
[semver]: https://semver.org/lang/de/spec/v2.0.0.html
[repository]: https://github.com/elvit/hassio-addons