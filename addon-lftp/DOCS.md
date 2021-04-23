# Home Assistant Add-on: LFTP Sync

TBD

## Installation

The installation of this add-on is pretty straightforward and not different in
comparison to installing any other Home Assistant add-on.

1. Search for the "LFTP Sync" add-on in the Supervisor add-on store and install it.
1. Start the "LFTP Sync" add-on
1. Check the logs of the "LFTP Sync" add-on to see if everything went well.

## Configuration

**Note**: _Remember to restart the add-on when the configuration is changed._

Example add-on configuration:

```yaml
TBD
```

**Note**: _This is just an example, don't copy and paste it! Create your own!_

### Option: `host`

TBD

### Option: `username`

TBD

### Option: `password`

TBD

### Option: `local_folder`

TBD

### Option: `remote_folder`

TBD

### Option: `direction`

The minimum port to allocate for PASV style data connections. Can be used to
specify a narrow port range to assist firewalling.

### Option: `parallel`

TBD

### Option: `copy_hidden_files`

TBD

### Option: `auto_confirm`

TBD

### Option: `no_certificate_check`

TBD

### Option: `delete`

TBD

### Option: `verbode`

TBD

### Option: `continue`

TBD

### Option: `script_file`

TBD

## Changelog & Releases

This repository keeps a change log using [GitHub's releases][releases]
functionality.

Releases are based on [Semantic Versioning][semver], and use the format
of `MAJOR.MINOR.PATCH`. In a nutshell, the version will be incremented
based on the following:

- `MAJOR`: Incompatible or major changes.
- `MINOR`: Backwards-compatible new features and enhancements.
- `PATCH`: Backwards-compatible bugfixes and package updates.

## Support

Got questions?

You can simply [open an issue here][issue] GitHub.

## Authors & contributors

The original setup of this repository is by [ElVit][elvit].


[lftp]: https://lftp.yar.ru/
[elvit]: https://github.com/elvit
[issue]: https://github.com/elvit/hassio-addons/addon-lftp/issues
[releases]: https://github.com/elvit/hassio-addons/addon-lftp/releases
[semver]: http://semver.org/spec/v2.0.0.htm
