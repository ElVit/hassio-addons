# Home Assistant Add-on: LFTP sync

## Installation

The installation of this add-on is pretty straightforward and not different in comparison to installing any other Home Assistant add-on.

1. Add this repository (`https://github.com/elvit/hassio-addons`) to your home assistant instance.
2. Search for the "LFTP sync" add-on in the Supervisor add-on store and install it.
3. Set the add-on options to your preferences
4. Click the `Save` button to store your configuration.
5. Start the "LFTP sync" add-on
6. Check the logs of the "LFTP sync" add-on to see if everything went well.

## Configuration

**Note**: _Remember to restart the add-on when the configuration is changed._

Example add-on configuration:

```yaml
script_dir: /config/addons-config/lftp
credentials:
  - url: 192.168.1.1
    username: dummyUser
    password: dummyPassowrd
```

## Options:

### Option: `script_dir`

The directory where the lftp scripts shall be stored.
An lftp script shall have the file extension "*.lftp".
If no file with the extension "*.lftp" is found in the defined directory, an example lftp script will be created.

### Option: `credentials.url`

The url of the remote site. used for authentication.
Please add only the URL without the protocol (e.g. ftp://, sftp://, ...). So for example 'my.site.com' or '192.168.1.1' would be correct.

### Option: `credentials.username`

The username of the remote site. used for authentication.

### Option: `credentials.password`

The password of the remote site. used for authentication.

## Writing a script

For more information to the lftp commands and parameters please see the official [General Commands Manual](https://lftp.yar.ru/lftp-man.html).
There is also a site with some usefull [lftp script examples](https://mrod.space/2019/10/04/lftp-examples.html#scripts) and command explanions.

## Automation
You may create an automation in home assistant if you want to run the lftp scripts scheduled.
For example:

```yaml
- id: home_assistant_run_backup
  alias: Home Assistant backup
  trigger:
    platform: time
    at: '01:00'
  action:
    service: hassio.addon_start
    data_template:
      addon: 8b00f271_lftp-conf
```

This will run all Rclone jobs configured in this addon at 01:00 in the morning.

## Changelog & Releases

Releases are based on [Semantic Versioning](https://semver.org/lang/de/spec/v2.0.0.html), and use the format of `MAJOR.MINOR.PATCH`.
In a nutshell, the version will be incremented based on the following:

- `MAJOR`: Incompatible or major changes.
- `MINOR`: Backwards-compatible new features and enhancements.
- `PATCH`: Backwards-compatible bugfixes and package updates.

## Support

Got questions?

You can simply [open an issue here](https://github.com/elvit/hassio-addons/issues) on GitHub.

## Authors & contributors

The original setup of this repository is made by [ElVit](https://github.com/elvit).
