# Home Assistant Add-on: Rsync daemon

## Installation

The installation of this add-on is pretty straightforward and not different in comparison to installing any other Home Assistant add-on.  

1. Click the Home Assistant My button below to open the add-on on your Home Assistant instance.   
   [![Open your Home Assistant instance and show the dashboard of an add-on.](https://my.home-assistant.io/badges/supervisor_addon.svg)](https://my.home-assistant.io/redirect/supervisor_addon/?addon=7c7b7dd6_rsyncd&repository_url=https%3A%2F%2Fgithub.com%2Felvit%2Fhassio-addons)  
2. Click the `Install` button to install the add-on.  
3. Go to the `Configuration` tab and set the options to your preferences  
4. Click the `Save` button to store your configuration.  
5. Go back to the `Info` tab and start this add-on.  
6. Check the logs in the `Log` tab to see if everything went well.   

## Configuration

Example add-on configuration:  

```yaml
rsync_commands:
  - --archive --recursive --compress --progress rsync://localhost/my_config_dir/ /backup/rsync/
  - --archive --recursive --compress --progress /media/my_smb_dir/ rsync://localhost/my_backup_dir/
```

The first command will copy all files from the server to the client (pull).  
The second command will copy all files from the client to the server (push).  
Since home assistant is also capable of mount SMB shares it is also possible to sync data from/to a SMB share (see second command).

To execute one of these rsync command you have to call the `hassio.addon_stdin` service in home assistant:

```yaml
service: hassio.addon_stdin
data:
  addon: 7c7b7dd6_rsyncd
  input: 0
```

The `input` element defines the index of the rsync command in the addon config list. In this example the first command will be executed.   

## Modifying the rsyncd.conf

A default `rsynd.conf` is created if there is no `rsync.d` file in the directory `/addons_config/7c7b7dd6_rsyncd/`.  
In the rsyncd.conf you can define directories which shall be exposed by the samba server.  
A full documentation how to use rsync or how to write a rsyncd.conf can be found [here](https://rsync.samba.org/documentation.html).  

## Options:

### Option: `rsync_commands`

A list of rsync command you want to execute.  
To execute a rsync command you have to call the `hassio.addon_stdin` service with a suitable index.  

## Changelog & Releases

Releases are based on [Semantic Versioning](https://semver.org/lang/de/spec/v2.0.0.html), and use the format of `MAJOR.MINOR.PATCH`.  
In a nutshell, the version will be incremented based on the following:  

- `MAJOR`: Incompatible or major changes.  
- `MINOR`: Backwards-compatible new features and enhancements.  
- `PATCH`: Backwards-compatible bugfixes and package updates.  

## Support

Got questions?  
You can simply [open an issue here](https://github.com/ElVit/hassio-addons/issues) on GitHub.  

## Authors & contributors

The original setup of this repository is made by [Poeschl](https://github.com/Poeschl):
- [Poeschl/Hassio-Addons/rsync](https://github.com/Poeschl/Hassio-Addons/tree/main/rsync)
