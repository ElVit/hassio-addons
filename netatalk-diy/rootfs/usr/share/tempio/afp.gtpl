; http://netatalk.sourceforge.net/3.1/htmldocs/afp.conf.5.html
[Global]
  ; output log entries to stdout instead of syslog
  ; it is the docker way where the engine in turn
  ; can direct the log output to a storage backend
  log file = /dev/stdout
  log level = default:warn
  ; use environment variable `username` to set what OSX finder calls the root share
  hostname = {{ .username }}
  ; turn on AFP stats gathering
  afpstats = yes
  ; Sets a message to be displayed when clients logon to the server. The message should be in unix charset and should be quoted. Extended characters are allowed.
  login message = Welcome to {{ .username }} !
  ; set the Mac model for Avahi icons
  mimic model = Xserve
  ; Whether to enable Spotlight searches. Note: once the global option is enabled, any volume that is not enabled won't be searchable at all. See also dbus daemon option.
  spotlight = {{ .spotlight }}
  ; Whether to use automatic Zeroconf service registration if Avahi or mDNSResponder were compiled in.
  zeroconf = {{ .zeroconf }}

[{{ .username }} - Shared]
  path = /share/afp/share
  valid users = @netatalk-files

[{{ .username }} - Time Machine]
  path = /share/afp/timemachine
  time machine = yes
  valid users = @netatalk-files