[global]
   netbios name = {{ env "HOSTNAME" }}
   workgroup = WORKGROUP
   server string = Samba Home Assistant
   security = user
   ntlm auth = yes
   load printers = no
   disable spoolss = yes
   log level = 2
   bind interfaces only = yes
   interfaces = {{ .interface }}
   hosts allow = 10.0.0.0/8 172.16.0.0/12 192.168.0.0/16 fe80::/10

[config]
   browseable = yes
   writeable = yes
   path = /config
   valid users = {{range .logins}}{{.username}},{{end}}
   force user = root
   force group = root
   veto files = /._*/.DS_Store/Thumbs.db/icon?/.Trashes/
   delete veto files = yes

[addons]
   browseable = yes
   writeable = yes
   path = /addons
   valid users = testuser
   force user = root
   force group = root
   veto files = /._*/.DS_Store/Thumbs.db/icon?/.Trashes/
   delete veto files = yes
   
[ssl]
   browseable = yes
   writeable = yes
   path = /ssl
   valid users = testuser
   force user = root
   force group = root
   veto files /._*/.DS_Store/Thumbs.db/icon?/.Trashes/
   delete veto files = yes

[share]
   browseable = yes
   writeable = yes
   path = /share
   valid users = testuser
   force user = root
   force group = root
   veto files = /._*/.DS_Store/Thumbs.db/icon?/.Trashes/
   delete veto files = yes

[backup]
   browseable = yes
   writeable = yes
   path = /backup
   valid users = testuser
   force user = root
   force group = root
   veto files = /._*/.DS_Store/Thumbs.db/icon?/.Trashes/
   delete veto files = yes

[media]
   browseable = yes
   writeable = yes
   path = /media
   valid users = testuser
   force user = root
   force group = root
   veto files = /._*/.DS_Store/Thumbs.db/icon?/.Trashes/
   delete veto files = yes
