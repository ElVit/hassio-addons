# Home Assistant Add-on: Rclone

## Installation

The installation of this add-on is pretty straightforward and not different in comparison to installing any other Home Assistant add-on.  

1. Add this repository (`https://github.com/elvit/hassio-addons`) to your home assistant instance.  
2. Search for the "Rclone" add-on in the Supervisor add-on store and install it.  
3. Set the add-on options to your preferences  
4. Click the `Save` button to store your configuration.  
5. Start the "Rclone" add-on  
6. Check the logs of the "Rclone" add-on to see if everything went well.  

## Configuration

Example add-on configuration:  

```yaml
config_file: /config/addons-config/rclone/rclone.conf
jobs:
  - name: Sync job
    source: /share/sourceDir
    destination: DummyRemote:/destinationDir
    command: sync
    options: --dry-run --verbose
```

## Options:

### Option: `config_file`

The path to the Rclone configuration file.  
If the path is invalid then a default rclone.conf file will be created.  

Here an example conf file:  

```conf
[DummyRemote]
type = owncloud
url = https://some.owncloudhost.com/remote.php/webdav/
vendor = owncloud
user = homeassistant
pass = *** ENCRYPTED PASS ***
```

### Option: `name`

The name of the Rclone job  

### Option: `source`

The source directory where the files will be copied from.  
This may be a local directory or a remote directory.  
- Remotes directories shall start with a remote location (from rclone.conf) followed by a ":" and the directory path.  
- Local directories shall start with /addons, /backup, /config, /media, /share or /ssl.  

### Option: `destination`

The destination directory where the files will be copied to.  
This may be a local directory or a remote directory.  
- Remotes directories shall start with a remote location (from rclone.conf) followed by a ":" and the directory path.  
- Local directories shall start with /addons, /backup, /config, /media, /share or /ssl.  

### Option: `commands`

Please see the [rclone-manual](https://rclone.org/commands/) for all supported commands.  
Usually you would use "sync" or "copy".  

### Option: `options`

Please see the [rclone-manual](https://rclone.org/docs/#options) for all supported options.  
Recommanded options are:  
- --verbose: rclone will tell you about each file that is transferred and a small number of significant events.  
- --dry-run: Do a trial run with no permanent changes. Use this to see what rclone would do without actually doing it. Useful when setting up the sync command which deletes files in the destination.  

## Automations

This add-on can easily be used with an automation. For instance:

```yaml
- id: home_assistant_run_backup
  alias: Home Assistant backup
  trigger:
    platform: time
    at: '07:30'
  action:
    service: hassio.addon_start
    data_template:
      addon: 32de6d38_rclone
```

Which will run all Rclone jobs at 07:30 in the morning.
