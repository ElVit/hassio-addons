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
config_file: /config/config.yaml
env_vars: 
  - EXAMPLE_ENV_VAR=dummyContent
users:
  - username: dummyUser
    password: '!secret password'
```

**HINT**: You may also use [home assistant secrets](https://www.home-assistant.io/docs/configuration/secrets/) in your addon-configuration.  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;At least for your password it is highly recommended to use it.

## Modifying the config.yaml

A full documentation how to write a config file can be found [here](https://github.com/hacdias/webdav).  
A default `config.yaml` is created if the file defined in the option `config_file` is not available.  

Here an example how the content of an config can look like:

```yaml
# For a more complete configuration see:
# https://github.com/hacdias/webdav

# Server related settings
auth: true
tls: false

# Default user settings (will be merged)
scope: /share/webdav
modify: true

# User settings
users:
  - username: "{env}USERNAME_0"
    password: "{env}PASSWORD_0"
    scope: /share/webdav
    modify: true
```

The users defined in the options will be saved as environment variables.  
The `username` sub-options will be saved in the environment variable `USERNAME_` + index.  
The `password` sub-options will be saved in the environment variable `PASSWORD_` + index.  
E.g. for the first user the env_vars `USERNAME_0` and `PASSWORD_0` will be created.  
These environment variables can nor be used in the config file (see the example above).  

## Options:

### Option: `config_file` (mandatory)

Define here the location of the config file.  
A config file can be of type json, toml, yaml or yml.  
Possible values which can be used in this file are described here: https://github.com/hacdias/webdav  

### Option `env_vars` (optional)

Optional environment variables that can be added.  
To set a config option via an environment variable the environment variables shall be prefixed by `WD_` followed by the option name in caps.  
So to set `cert` with the value `cert.pem` via an env variable, you should set `WD_CERT=cert.pem`.  

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

### Port `8801`, EntryPoint `WebDAV`

Port 8801 is used for WebDAV access. 
