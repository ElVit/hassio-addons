# Home Assistant Add-on: WebDAV server

## Installation

The installation of this add-on is pretty straightforward and not different in comparison to installing any other Home Assistant add-on.  

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
users:
  - username: dummyUser
    password: '!secret password'
```

**HINT**: You may also use [home assistant secrets](https://www.home-assistant.io/docs/configuration/secrets/) in your addon-configuration.  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;At least for your password it is highly recommended to use it.

**HINT**: Please be aware that if the path `/config/*` is used in the addon-configuration, this path is actually mapped to the directoy `/addon_configs/xxxxxxxx_webdav/`.  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`xxxxxxxx` is a random hex number probably some kind of hash value.  

## Modifying the config.yaml

A full documentation how to write a config file can be found [here](https://redmine.lighttpd.net/projects/lighttpd/wiki/Docs).  
A default `lighttpd.conf` and `webdav.conf` is created in the addon config directory (e.g. `/addon_configs/xxxxxxxx_webdav/`) if they are not available there.  

## Options:

### Option: `users.username` (mandatory)

A username to authenticate against the WebDAV server.  
It is possible to define multipe username/password options.  
This username will be stored in an environment variable and can be used in the config file like so:  
`username: "{env}USERNAME_0"`

### Option: `users.password` (mandatory)

A password to authenticate against the WebDAV server.  
It is possible to define multipe username/password options.  
This password will be stored in an environment variable and can be used in the config file like so:  
`password: "{env}PASSWORD_0"`

### Port `8080`, EntryPoint `WebDAV`

Port 8801 is used for WebDAV access. 
