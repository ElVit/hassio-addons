# This is a example lftp script. Please edit before using !!!

set cmd:fail-exit yes
set sftp:auto-confirm yes
set ssl:verify-certificate no
set log:enable yes
set log:file "{{ .script_dir }}/script.log"

open ftp://dummyUser@192.168.1.1

lcd /share/localDir
cd /remoteDir

mirror --verbose=1 \
      --dry-run \
      --continue \
      --delete \
      --parallel=4 \
      --exclude-glob="*.piolibdeps"

bye
