# Home Assistant Add-on: Traefik

## Installation

Follow these steps to get the add-on installed on your system:

1. Click the Home Assistant My button below to open the add-on on your Home Assistant instance.   
   [![Open your Home Assistant instance and show the dashboard of an add-on.](https://my.home-assistant.io/badges/supervisor_addon.svg)](https://my.home-assistant.io/redirect/supervisor_addon/?addon=bb4914d7_traefik&repository_url=https%3A%2F%2Fgithub.com%2Felvit%2Fhassio-addons)  
2. Click the `Install` button to install the add-on.  
3. Go to the `Configuration` tab and set the options to your preferences  
4. Click the `Save` button to store your configuration.  
5. Go back to the `Info` tab and start this add-on.  
6. Check the logs in the `Log` tab to see if everything went well.   

## How to use

In the configuration section you will need to set the required configuration path.  
This can be a directory within your Home Assistant config or Hass.io share directories, since both are read-only mounted on this add-on.  

Any Traefik endpoint configuration you put in there will be automatically picked up by this add-on.  
Updates will also be automatically processed by Traefik.  

You can also enable Let's Encrypt support within the configuration and set additional environment variables when those are needed.  

This add-on provides two Traefik entrypoints. `web` on port 80 and `web-secure` on port 443.  

### Example dynamic Traefik configuration

```yaml
http:
  routers:
    redirectToHttpsRouter:
      entryPoints: ["web"]
      middlewares: ["httpsRedirect"]
      rule: "HostRegexp(`{host:.+}`)"
      service: noopService

    homeAssistantRouter:
      rule: "Host(`hass.io`)"
      entryPoints: ["web-secure"]
      tls:
        certResolver: le
      service: homeAssistantService

  middlewares:
    httpsRedirect:
      redirectScheme:
        scheme: https

  services:
    noopService:
      loadBalancer:
        servers:
          - url: "http://192.168.1.10"

    homeAssistantService:
      loadBalancer:
        servers:
          - url: "http://192.168.1.10:8123"
```

## Configuration

Full add-on example configuration for Let's Encrypt with Cloudflare DNS proxy and dynamic configuration within your Home Assistant configuration directory: 

```yaml
custom_static_config: false
log_level: INFO
access_logs: false
forwarded_headers_insecure: true
letsencrypt:
  enabled: true
  email: example@home-assistant.io
  challenge_type: dnsChallenge
  provider: cloudflare
  delayBeforeCheck: 10
  resolvers:
    - '1.1.1.1:53'
env_vars:
  - CF_DNS_API_TOKEN=YOUR-API-TOKEN-HERE
  - ANOTHER_ENV_VARIABLE=SOME-VALUE
```

> [!TIP]  
> Please be aware that if the path `/config/*` is used in the addon-configuration,  
> this path is actually mapped to the directoy `/addon_configs/bb4914d7_traefik/`.  

### Option `custom_static_config` (mandatory)

Enable this option to use a custom static configuration (traefik.yaml).  
If there is no `traefik.yaml` in the directory `/addon_configs/bb4914d7_traefik/`, a default `traefik.yaml` is created.  
If this option is disabled, a default `traefik.yaml` is created each time the addon is started.  
If this option is enabled, your current `traefik.yaml` will be used on next addon start.  

### Option `log_level` (mandatory)

The `log_level` option controls the level of log output by the addon and Enable this option to use a custom smb.conf.  
If there is no smb.conf file in the `config_dir` directory, then a default smb.conf is created.  
If this option is disabled a default smb.conf is created each time the addon is started.  can
be changed to be more or less verbose, which might be useful when you are
dealing with an unknown issue. Possible values are: 

- `trace`: Show every detail, like all called internal functions.
- `debug`: Shows detailed debug information.
- `info`: Normal (usually) interesting events.
- `warning`: Exceptional occurrences that are not errors.
- `error`:  Runtime errors that do not require immediate action.
- `fatal`: Something went terribly wrong. Add-on becomes unusable.

Please note that each level automatically includes log messages from a
more severe level, e.g., `debug` also shows `info` messages. By default,
the `log_level` is set to `info`, which is the recommended setting unless
you are troubleshooting. 

### Option `access_logs` (mandatory)

Whether to enable access logging to standard out.  
These logs will be shown in the Hass.io Add-On panel. 

### Option `forwarded_headers_insecure` (mandatory)

Enables insecure forwarding headers.  
When this option is enabled, the forwarded headers (`X-Forwarded-*`) will not be replaced by Traefik headers.  
Only enable this option when you trust your forwarding proxy. 

> [!NOTE]  
> for Cloudflare `X-Forwarded-*` proxied headers to work, this must be enabled.  

### Option `letsencrypt.enabled` (mandatory)

Whether or not to enable Let's Encrypt. When this is enabled the `le` certResolver will be activated for you to use.  
You will also have to set the Let's Encrypt e-mail and challange type. Otherwise Traefik will fail to start. 

### Option `letsencrypt.email` (optional)

Your personal e-mail that you want to use for Let's Encrypt. 

> [!NOTE]  
> This is required when Let's Encrypt is enabled.  

### Option `letsencrypt.challenge_type` (optional)

A challange type you want to use for Let's Encrypt. Valid options are: 

* `tlsChallenge`
* `httpChallenge`
* `dnsChallenge`

For more information on challange types and which one to choose,  
please see the [ACME section](https://docs.traefik.io/https/acme/) of the Treafik documentation regarding this subject. 

### Option `letsencrypt.provider` (optional)

When using the `dnsChallange` you will also need to set a provider to use.  
The list of providers can be found in the [Let's Encrypt provider section](https://docs.traefik.io/https/acme/#providers) of the Traefik documentation. 

### Option `letsencrypt.delayBeforeCheck` (optional)

By default, the provider will verify the TXT DNS challenge record before letting ACME verify.  
If `delayBeforeCheck` is set and greater than zero, this check is delayed for the configured duration in seconds. 

This setting can be useful if internal networks block external DNS queries. For more information,  
check the [Traefik documentation](https://docs.traefik.io/https/acme/#dnschallenge) regarding this subject. 

### Option `letsencrypt.resolvers` (optional)

Manually set the DNS servers to use when performing the verification step.  
Useful for situations where internal DNS does not resolve to the same addresses as the public internet (e.g. on a LAN using a FQDN as part of hostnames). 

For more information, see the [Traefik documentation](https://docs.traefik.io/https/acme/#resolvers) regarding this subject. 

### Option `env_vars` (optional)

Optional environment variables that can be added.  
These additional configuration values can be necessary for example for the Let's Encrypt DNS challange provider.  
See the example configuration above for an concrete example. 

## Ports

This image exposes two ports for HTTP(S) access.  
These are also configured within Traefik as entrypoints.  
You can use these within your dynamic configuration.

### Port `80`, EntryPoint `web`

Port 80 is used for HTTP access. 

When using a supported Let's Encrypt provider (ie. Cloudflare) with DNS Challange you can also map this port to another,  
random port and let CloudFlare do the HTTP to HTTPS forwarding. 

### Port `443`, EntryPoint `web-secure`

Port 443 is used for HTTPS access. 

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

The original setup of this repository is made by [alex3305](https://github.com/alex3305):
- [alex3305/home-assistant-addons/traefik](https://github.com/alex3305/home-assistant-addons/blob/master/traefik)
