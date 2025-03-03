# Home Assistant Add-on: Bitwarden secrets for Home Assistant

## Installation

Follow these steps to get the add-on installed on your system:

1. Click the Home Assistant My button below to open the add-on on your Home Assistant instance.   
   [![Open your Home Assistant instance and show the dashboard of an add-on.](https://my.home-assistant.io/badges/supervisor_addon.svg)](https://my.home-assistant.io/redirect/supervisor_addon/?addon=bb4914d7_bitwarden-secrets&repository_url=https%3A%2F%2Fgithub.com%2Felvit%2Fhassio-addons)  
2. Click the `Install` button to install the add-on.  
3. Go to the `Configuration` tab and set the options to your preferences  
4. Click the `Save` button to store your configuration.  
5. Go back to the `Info` tab and start this add-on.  
6. Check the logs in the `Log` tab to see if everything went well.   

## How to use

You will need to have a Bitwarden account to use. It is also recommended that you use the [Bitwarden Add-on](https://github.com/hassio-addons/addon-bitwarden) for Home Assistant for easy local access to all your secrets.

> [!WARNING]  
> Running this add-on will overwrite your `secrets.yaml` file and other secret files you retrieve from Bitwarden!  
> Make a snapshot/backup of your Home Assistant configuration before proceeding.  

> [!TIP]  
> See my personal [Bitwarden set up](https://alex3305.github.io/home-assistant-docs/add-ons/bitwarden/) for more information regarding the Bitwarden setup.  

### Bitwarden management

For every **Login** item the _Username_ and _Password_ fields are leveraged into secrets that are parsed into yaml. For instance:

| Item | Username | Password |
| ---- | -------- | -------- |
| My Super Secret API Key |  | 1Wp08FwDFa4aEP39 |
| MariaDB | mariadb_user | this-is-my-database-password! |

is parsed into:

```yaml
# Home Assistant secrets file
# DO NOT MODIFY -- Managed by Bitwarden Secrets for Home Assistant add-on

my_super_secret_api_key_password: '1Wp08FwDFa4aEP39'
mariadb_username: 'mariadb_user'
mariadb_password: 'this-is-my-database-password!'
```

> [!NOTE]  
> YAML formatting still applies!  

> [!NOTE]  
> Refrain from using control characters inside item names.  

Custom fields are also supported. The field type "Hidden" and "Text" are treated equally and their text will be written. The "Boolean" Field Type will be written as `true` or `false`. Example:

| Item | Text | Hidden | Boolean |
| ---- | ---- | ------ | ------- |
| Custom Fields | my text | secret text | ☑️ |

is parsed into:

```yaml
# Home Assistant secrets file
# DO NOT MODIFY -- Managed by Bitwarden Secrets for Home Assistant add-on

custom_fields_text: 'my text'
custom_fields_hidden: 'secret text'
custom_fields_boolean: 'true'
```
> [!NOTE]  
> The custom field type "Linked" is not supported yet.  

Besides creating a `secrets.yaml` file, you can also easily manage secret files. For every **Note** item in the Bitwarden vault, a secret file will be created from the _Name_ with the _Note contents_. For instance:

| Item | Note contents (partial) |
| ---- | ----------------------- |
| google_assistant_service_key.json | `{"type": "service_account","project_id": "my-google-assistant-project-1273"...` |

is parsed into `google_assistant_service_key.json` in your Home Assistant configuration directory with the contents:

```json
{
  "type": "service_account",
  "project_id": "my-google-assistant-project-1273",
  "private_key_id": "priv-key-id",
  "private_key": "-----BEGIN PRIVATE KEY-----\n[REDACTED]\n-----END PRIVATE KEY-----\n",
  "client_email": "homeassistant@my-google-assistant-project-1273.iam.gserviceaccount.com",
  "client_id": "13743492346842924234",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/my-google-assistant-project-1273.iam.gserviceaccount.com"
}
```

> [!NOTE]  
> Subdirectories are support with forward slashes (ie. `config/rclone.conf`). The directories are created when necessary.  

## Configuration

```yaml
log_level: info
bitwarden:
  server: 'http://a0d7b954-bitwarden:7277/'
  username: homeassistant@localhost.lan
  password: homeassistant
  organization: Home Assistant
repeat:
  active: false
  interval: 300
```

### Option `log_level` (required)

The `log_level` option controls the level of log output by the addon and can
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

### Option `bitwarden.server` (required)

Bitwarden server. This defaults to the DNS name of the Vaultwarden Home Assistand add-on, but can be changed to your liking.

### Option `bitwarden.username` (required)

The username to login to Bitwarden with.

### Option `bitwarden.password` (required)

The password to login to Bitwarden with. This can optinoally be changed to a secret value (ie. `!secret bitwarden_password`) after the first sync.

### Option `bitwarden.organization` (required)

The required organization that is used to retrieve your secret items.

### Option `repeat.enabled` (required)

When `true` this enables automatic refreshing of your secrets.

### Option `repeat.interval` (optional)

Interval, in seconds, to refresh your secrets from Bitwarden. This value is only required when `repeat.enabled` is set to `true`. If set to e.g. 3600 the secrets.yaml file will be created every hour (60 sec = 1 min * 60 = 1 hour).

### option `secrets_file` (optional)

Optionally define an alternative secrets file path to parse the secrets into. Providing this value can be useful for testing and debugging this add-on.  
If this option is not set the default path `/homeassistant/secrets.yaml` is used.

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
- [alex3305/home-assistant-addons/bitwarden_secrets](https://github.com/alex3305/home-assistant-addons/blob/master/bitwarden-secrets)
