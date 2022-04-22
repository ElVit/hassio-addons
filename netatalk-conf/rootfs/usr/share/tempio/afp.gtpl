; http://netatalk.sourceforge.net/3.1/htmldocs/afp.conf.5.html
[Global]
  ; output log entries to stdout instead of syslog
  ; it is the docker way where the engine in turn
  ; can direct the log output to a storage backend
  log file = /dev/stdout
  log level = default:debug
  ; use environment variable `HOSTNAME` to set what OSX finder calls the root share
  hostname = {{ env "HOSTNAME" }}
  ; turn on AFP stats gathering
  afpstats = yes
  ; Sets a message to be displayed when clients logon to the server. The message should be in unix charset and should be quoted. Extended characters are allowed.
  login message = Welcome to {{ env "HOSTNAME" }}!
  ; set the Mac model for Avahi icons
  mimic model = AirPort
  ; Whether to enable Spotlight searches. Note: once the global option is enabled, any volume that is not enabled won't be searchable at all. See also dbus daemon option.
  spotlight = yes
  ; Whether to use automatic Zeroconf service registration if Avahi or mDNSResponder were compiled in.
  zeroconf = yes
  ; Specifies the network interfaces that the server should listens on. The default is advertise the first IP address of the system, but to listen for any incoming request.
  afp interfaces = {{ .interface }}
  ; This specifies a UNIX user name that will be assigned as the default user for all users connecting to this server. This is useful for sharing files. You should also use it carefully as using it incorrectly can cause security problems.
  force user = root
  ; This specifies a UNIX group name that will be assigned as the default primary group for all users connecting to this server.
  force group = root

[Shared]
  path = /share/netatalk-shared
  valid users = {{range .logins}}{{.username}} {{end}}
  veto files = /._*/.DS_Store/Thumbs.db/icon?/.Trashes/
  hosts allow = 10.0.0.0/8 172.16.0.0/12 192.168.0.0/16 fe80::/10

[Time Machine]
  path = /share/timemachine
  time machine = yes
  valid users = {{range .logins}}{{.username}} {{end}}
  veto files = /._*/.DS_Store/Thumbs.db/icon?/.Trashes/
  hosts allow = 10.0.0.0/8 172.16.0.0/12 192.168.0.0/16 fe80::/10#
