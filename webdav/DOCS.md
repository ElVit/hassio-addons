# Home Assistant Add-on: WebDAV server

## Installation

Follow these steps to get the add-on installed on your system:

1. Click the Home Assistant My button below to open the add-on on your Home Assistant instance.   
   [![Open your Home Assistant instance and show the dashboard of an add-on.](https://my.home-assistant.io/badges/supervisor_addon.svg)](https://my.home-assistant.io/redirect/supervisor_addon/?addon=bb4914d7_webdav&repository_url=https%3A%2F%2Fgithub.com%2Felvit%2Fhassio-addons)  
2. Click the `Install` button to install the add-on.  
3. Go to the `Configuration` tab and set the options to your preferences  
4. Click the `Save` button to store your configuration.  
5. Go back to the `Info` tab and start this add-on.  
6. Check the logs in the `Log` tab to see if everything went well.   

## Configuration

Example add-on configuration:  

```yaml
custom_config: false
document_root: /share/webdav
users:
  - username: dummyUser
    password: '!secret password'
```

> [!TIP]  
> You may also use [home assistant secrets](https://www.home-assistant.io/docs/configuration/secrets/) in your addon-configuration.  
> At least for your password it is highly recommended to use it.  

> [!TIP]  
> Please be aware that if the path `/config/*` is used in the addon-configuration,  
> this path is actually mapped to the directoy `/addon_configs/bb4914d7_webdav/`.  

## Modifying the lighttpd.conf and webdav.conf

A full documentation how to write a config file can be found [here](https://redmine.lighttpd.net/projects/lighttpd/wiki/Docs).  
A default `lighttpd.conf` and `webdav.conf` is created in the addon config directory (e.g. `/addon_configs/bb4914d7_webdav/`) if they are not available there.  

### Option: `custom_config` (mandatory)

Enable this option to use a custom `lighttpd.conf` and `webdav.conf`.  
If there is no `lighttpd.conf` or `webdav.conf` in the directory `/addon_configs/bb4914d7_webdav/`, a default `lighttpd.conf` or `webdav.conf` is created.  
If this option is disabled, a default `lighttpd.conf` or `webdav.conf` is used to run this addon.  
If this option is enabled, your current `lighttpd.conf` or `webdav.conf` will be used on next addon start.  

### Option: `document_root` (mandatory)

Set here the root direcory for your webdav server.  
This option may have no effect if you set the option `custom_config` to `true`.  

### Option: `logins.username` (mandatory)

A username to authenticate against the webdav server.  
It is possible to define multipe username/password options, but at least one username/password is needed to start the webdav server.  
This username can be used in your custom smb.conf.  

### Option: `logins.password` (mandatory)

A password to authenticate against the webdav server.  
It is possible to define multipe username/password options, but at least one username/password is needed to start the webdav server.  

### Port `8080`, EntryPoint `WebDAV`

Port 8080 is used for WebDAV access. 

## Changelog & Releases

Releases are based on [Semantic Versioning](https://semver.org/lang/de/spec/v2.0.0.html), and use the format of `MAJOR.MINOR.PATCH`.  
In a nutshell, the version will be incremented based on the following:  

- `MAJOR`: Incompatible or major changes.  
- `MINOR`: Backwards-compatible new features and enhancements.  
- `PATCH`: Backwards-compatible bugfixes and package updates.  

## Support

Got questions?  
You can simply [open an issue here](https://github.com/ElVit/hassio-addons/issues) on GitHub.  
