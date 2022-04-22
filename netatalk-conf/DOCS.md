# Home Assistant Add-on: Netatalk share

## Installation

The installation of this add-on is pretty straightforward and not different in comparison to installing any other Home Assistant add-on.  

1. Add this repository (`https://github.com/elvit/hassio-addons`) to your home assistant instance.  
2. Search for the "Netatalk share" add-on in the Supervisor add-on store and install it.  
3. Set the add-on options to your preferences  
4. Click the `Save` button to store your configuration.  
5. Start the "Netatalk share" add-on  
6. Check the logs of the "Netatalk share" add-on to see if everything went well.  

## Configuration

**Note**: _Remember to restart the add-on when the configuration is changed._

Example add-on configuration:  

```yaml
logins:
  - username: homeassistant
    password: YOUR_PASSWORD
config_dir: /config/addons-config/netatalk
```

## Options:

### Option: `username`

A username to authenticate against the netatalk server.  

### Option: `password`

A password to authenticate against the netatalk server.  

### Option: `config_dir`

The directory where the afp.conf file shall be stored.  
Each time the addon is started the afp.conf file is copied to the original directory where it will be used.  

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


[elvit]: https://github.com/elvit
[issue]: https://github.com/elvit/hassio-addons/issues
[semver]: https://semver.org/lang/de/spec/v2.0.0.html
