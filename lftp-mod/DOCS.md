# Home Assistant Add-on: LFTP sync

## Installation

The installation of this add-on is pretty straightforward and not different in comparison to installing any other Home Assistant add-on.  

1. [Add my Hass.io add-ons repository][repository] to your home assistant instance.  
1. Search for the "LFTP sync" add-on in the Supervisor add-on store and install it.  
1. Set the add-on options to your preferences  
1. Click the `Save` button to store your configuration.  
1. Start the "LFTP sync" add-on  
1. Check the logs of the "LFTP sync" add-on to see if everything went well.  

## Configuration

**Note**: _Remember to restart the add-on when the configuration is changed._

Example add-on configuration:  

```yaml
username: admin
password: password
script_dir: /config/addons-config/lftp
```

### Option: `username`

The username of the remote site. used for authentication.  

### Option: `password`

The password of the remote site. used for authentication.  

### Option: `script_dir`

The directory where the lftp scripts shall be stored.  
An lftp script shall have the file extension "*.lftp".  
If no file with the extension "*.lftp" is found in the defined directory, an example lftp script will be created.  

For more information to the lftp commands and parameters plese see the official [General Commands Manual][lftp].  
You may create an automation in home assistant if you want to run the lftp scripts scheduled.  

## Changelog & Releases

Releases are based on [Semantic Versioning][semver], and use the format of `MAJOR.MINOR.PATCH`.  
In a nutshell, the version will be incremented based on the following:  

- `MAJOR`: Incompatible or major changes.  
- `MINOR`: Backwards-compatible new features and enhancements.  
- `PATCH`: Backwards-compatible bugfixes and package updates.  

## Support

Got questions?

You can simply [open an issue here][issue] on GitHub.  

## Authors & contributors

The original setup of this repository is made by [ElVit][elvit].  


[lftp]: https://lftp.yar.ru/lftp-man.html
[elvit]: https://github.com/elvit
[issue]: https://github.com/elvit/hassio-addons/issues
[semver]: https://semver.org/lang/de/spec/v2.0.0.html
[repository]: https://github.com/elvit/hassio-addons
