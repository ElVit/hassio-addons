#!/usr/bin/with-contenv bashio
set -e #echo on

# LFTP commands: http://lftp.yar.ru/lftp-man.html

bashio::log.info "=== addon start ==="

HOST=$(bashio::config 'host')
USER=$(bashio::config 'username')
PASS=$(bashio::config 'password')
RCD=$(bashio::config 'remote_folder')
LCD=$(bashio::config 'local_folder')
FILE=$(bashio::config 'script_file')

### Settings ###
SETTINGS=""

if [ "$(bashio::config 'copy_hidden_files')" = true ] ; then
  # copy also hidden files (e.g. .htaccess)
  SETTINGS="${SETTINGS}set ftp:list-options -a; "
fi

if [ "$(bashio::config 'auto_confirm')" = true ] ; then
  # continue job although the ssh host key has changed
  SETTINGS="${SETTINGS}set sftp:auto-confirm yes; "
fi

if [ "$(bashio::config 'no_certificate_check')" = true ] ; then
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

if [ "$(bashio::config 'continue')" = true ] ; then
  # do not redownload files if they were deleted during a mirror job
  MIRROR="${MIRROR} --continue"
fi

if [ "$(bashio::config 'delete')" = true ] ; then
  # delete files not present at the source
  MIRROR="${MIRROR} --delete"
fi

if [ "$(bashio::config 'verbose')" = true ] ; then
  # print to the log
  MIRROR="${MIRROR} --verbose"
fi

if [ "$(bashio::config 'direction')" = "upload" ] ; then
  # upload files instead of downloading them
  MIRROR="${MIRROR} --reverse"
fi

# https://superuser.com/questions/75681/inverse-multiplexing-to-speed-up-file-transfer
if [ "$(bashio::config 'parallel')" = "many_small_files" ] ; then
  MIRROR="${MIRROR} --parallel=100"
elif [ "$(bashio::config 'parallel')" = "few_large_files" ] ; then
  MIRROR="${MIRROR} --parallel=2 --use-pget-n=10"
fi

MIRROR="${MIRROR}; "

bashio::log.info "Start mirror job with lftp\n from '${RCD}'\n to '${LCD}'"

if bashio::fs.file_exists "$FILE"; then
  bashio::log.info "using script_file (-f):\n located at ${FILE}"
  lftp -f "${FILE}"
else
  bashio::log.info "using commands (-c):\n ${SETTINGS}\n open ${HOST};\n user ${USER} *****;\n lcd ${LCD};\n cd ${RCD};\n ${MIRROR}"
  lftp -c "${SETTINGS} ${COMMANDS} ${MIRROR}" 
fi

bashio::log.info "=== addon end ==="
bashio::exit.ok
