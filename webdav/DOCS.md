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
tls: false
username: dummyUser
password: '!secret password'
```

**HINT**: You may also use [home assistant secrets](https://www.home-assistant.io/docs/configuration/secrets/) in your addon-configuration.  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;At least for your password it is highly recommended to use it.

## Modifying the dav.conf

TBD