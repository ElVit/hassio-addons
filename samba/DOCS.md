# Home Assistant Add-on: Samba server

## Installation

Follow these steps to get the add-on installed on your system:

1. Click the Home Assistant My button below to open the add-on on your Home Assistant instance.   
   [![Open your Home Assistant instance and show the dashboard of an add-on.](https://my.home-assistant.io/badges/supervisor_addon.svg)](https://my.home-assistant.io/redirect/supervisor_addon/?addon=bb4914d7_samba&repository_url=https%3A%2F%2Fgithub.com%2Felvit%2Fhassio-addons)  
2. Click the `Install` button to install the add-on.  
3. Go to the `Configuration` tab and set the options to your preferences  
4. Click the `Save` button to store your configuration.  
5. Go back to the `Info` tab and start this add-on.  
6. Check the logs in the `Log` tab to see if everything went well.   

## Configuration

Example add-on configuration:  

```yaml
custom_config: true
config_dir: /config/addons-config/samba
logins:
  - username: dummyUser
    password: '!secret password'
```

> [!TIP]  
> You may also use [home assistant secrets](https://www.home-assistant.io/docs/configuration/secrets/) in your addon-configuration.  
> At least for your password it is highly recommended to use it.  

> [!TIP]  
> Please be aware that if the path `/config/*` is used in the addon-configuration,  
> this path is actually mapped to the directoy `/addon_configs/bb4914d7_samba/`.  

## Modifying the smb.conf

A default `smb.conf` is created on each start and will be saved to the directory `/addon_configs/bb4914d7_samba/`.  
If you enable the option `custom_config` the smb.conf will only be created once.  
Then you can modify it and yor changes will be kept even when you restart the addon.  
In the smb.conf you can define directories that shall be exposed by the samba server.  
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

### Option: `custom_config` (mandatory)

Enable this option to use a custom `smb.conf`.  
If there is no `smb.conf` in the directory `/addon_configs/bb4914d7_samba/`, a default `smb.conf` is created.  
If this option is disabled, a default `smb.conf` is created each time the addon is started.  
If this option is enabled, your current `smb.conf` will be used on next addon start.  

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
