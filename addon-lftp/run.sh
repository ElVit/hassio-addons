#!/usr/bin/with-contenv bashio
set -e #echo on

# LFTP commands: http://lftp.yar.ru/lftp-man.html

bashio::log.info "=== addon start ==="

declare HOST
declare USER
declare PASS
declare RCD
declare LCD
declare FILE

HOST=$(bashio::config 'host')
USER=$(bashio::config 'username')
PASS=$(bashio::config 'password')
RCD=$(bashio::config 'remote_folder')
LCD=$(bashio::config 'local_folder')
FILE=$(bashio::config 'script_file')

### Settings ###
SETTINGS=""

if bashio::config.true 'copy_hidden_files'; then
  # copy also hidden files (e.g. .htaccess)
  SETTINGS="${SETTINGS}set ftp:list-options -a; "
fi

if bashio::config.true 'auto_confirm'; then
  # continue job although the ssh host key has changed
  SETTINGS="${SETTINGS}set sftp:auto-confirm yes; "
fi

if bashio::config.true 'no_certificate_check'; then
  # do not check ssl certificate
  SETTINGS="${SETTINGS}set ssl:verify-certificate no; "
fi

### Commands ###
COMMANDS=""
COMMANDS="${COMMANDS}open ${HOST}; "
COMMANDS="${COMMANDS}user $USER $PASS; "
COMMANDS="${COMMANDS}lcd ${LCD}; "
COMMANDS="${COMMANDS}cd ${RCD}; "

### Mirror OPTS ###
MIRROR="mirror"

if bashio::config.true 'continue'; then
  # do not redownload files if they were deleted during a mirror job
  MIRROR="${MIRROR} --continue"
fi

if bashio::config.true 'delete'; then
  # delete files not present at the source
  MIRROR="${MIRROR} --delete"
fi

if bashio::config.true 'verbose'; then
  # print to the log
  MIRROR="${MIRROR} --verbose"
fi

if bashio::config.equals 'direction' 'upload'; then
  # upload files instead of downloading them
  MIRROR="${MIRROR} --reverse"
fi

# https://superuser.com/questions/75681/inverse-multiplexing-to-speed-up-file-transfer
if bashio::config.equals 'parallel' 'many_small_files'; then
  MIRROR="${MIRROR} --parallel=100"
elif bashio::config.equals 'parallel' 'few_large_files'; then
  MIRROR="${MIRROR} --parallel=2 --use-pget-n=10"
fi

if bashio::config.has_value 'exclude_glob'; then
  for exclude in $(bashio::config 'exclude_glob'); do
    MIRROR="${MIRROR} --exclude-glob='${exclude}'"
  done
fi

MIRROR="${MIRROR}; "

bashio::log.info "Start mirror job with lftp\n from '${RCD}'\n to '${LCD}'"

if bashio::config.has_value 'script_file'; then
  if bashio::fs.file_exists "${FILE}"; then
    bashio::log.info "using script_file (-f):\n located at ${FILE}"
    lftp -f "${FILE}"
  else
    bashio::exit.nok "The script_file '${FILE}' does not exist."
  fi
else
  bashio::log.info "using commands (-c):\n ${SETTINGS}\n open ${HOST};\n user ${USER} *****;\n lcd ${LCD};\n cd ${RCD};\n ${MIRROR}"
  lftp -c "${SETTINGS} ${COMMANDS} ${MIRROR}"
fi

bashio::log.info "=== addon end ==="
bashio::exit.ok
