# Home Assistant Add-on: Samba server

## Installation

The installation of this add-on is pretty straightforward and not different in comparison to installing any other Home Assistant add-on.  

1. Navigate in your Home Assistant frontend to __Supervisor -> Add-on Store__
2. Add this new repository by URL (`https://github.com/elvit/hassio-addons`)
3. Search for the "Samba server" add-on in the Supervisor add-on store and install it.  
4. Set the add-on options to your preferences  
5. Click the `Save` button to store your configuration.  
6. Start the "Samba server" add-on  
7. Check the logs of the "Samba server" add-on to see if everything went well.  

## Configuration

Example add-on configuration:  

```yaml
custom_config: true
config_dir: /config/addons-config/samba
logins:
  - username: dummyUser
    password: '!secret password'
```

**HINT**: You may also use [home assistant secrets](https://www.home-assistant.io/docs/configuration/secrets/) in your addon-configuration.  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;At least for your password it is highly recommended to use it.

## Modifying the smb.conf

The default smb.conf is created if you enable the option `custom_config` and define a path in the option `config_dir`.  
Here you can define directories that shall be exposed by the samba server.  
A full documentation how to write a smb.conf can be found [here](https://www.samba.org/samba/docs/current/man-html/smb.conf.5.html).  

You can also add Mac OS Time Machine support to your smb.conf. Here an example:

```conf
[timemachine]
  comment = Time Machine
  browseable = yes
  writeable = yes
  path = /backup/timemachine
  valid users = dummyUser
  force user = root
  force group = root
  create mask = 0600
  directory mask = 0700
  spotlight = yes
  vfs objects = catia fruit streams_xattr
  fruit:aapl = yes
  fruit:time machine = yes
```

Please keep in mind to change the path or create the directory "/backup/timemachine".  

## Options:

### Option: `custom_config` (mandatory)

Enable this option to use a custom smb.conf.  
If there is no smb.conf file in the `config_dir` directory, then a default smb.conf is created.  
If this option is disabled a default smb.conf is created each time the addon is started.  

### Option: `config_dir` (optional)

The directory where the custom smb.conf file shall be stored.  
Each time the addon is started the smb.conf file is copied to the original directory where it will be used.  

### Option: `logins.username` (mandatory)

A username to authenticate against the samba server.  
It is possible to define multipe username/password options, but at least one username/password is needed to start the samba server.  
This username can be used in your custom smb.conf.  

### Option: `logins.password` (mandatory)

A password to authenticate against the samba server.  
It is possible to define multipe username/password options, but at least one username/password is needed to start the samba server.  

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

The original setup of this repository is taken from the [official samba share addon](https://github.com/home-assistant/addons/tree/master/samba).  

The following repository helped me by developing this addon:
- [Samba NAS addon from dianlight](https://github.com/dianlight/hassio-addons/tree/master/sambanas)
