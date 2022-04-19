set sftp:auto-confirm yes
set ssl:verify-certificate no
set xfer:log true
set xfer:log-file "{{ .script_dir }}/lftp.log"

open ftp://192.168.100.100  # <-- PLEASE CHANGE
user {{ .username }} {{ .password }}
lcd /share/localDir         # <-- PLEASE CHANGE
cd /remoteDir               # <-- PLEASE CHANGE

debug -t -o "{{ .script_dir }}/lftp_debug.log" 3
mirror --continue --delete --verbose=1 --parallel=100 --exclude-glob="*.piolibdeps" --exclude-glob="*.pioenvs"
bye