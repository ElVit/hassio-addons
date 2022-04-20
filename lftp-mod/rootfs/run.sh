#!/usr/bin/with-contenv bashio
# ==============================================================================
# Script for starting the lftp scripts
# ==============================================================================
declare script_dir

# LFTP commands: http://lftp.yar.ru/lftp-man.html

bashio::log.info "=== addon start ==="
bashio::log.info "Using LFTP version:"
lftp --version
bashio::log.info "-----------------------"

# ToDo: DOCS ergänzen
# - https://superuser.com/questions/75681/inverse-multiplexing-to-speed-up-file-transfer
# - Übertragungsrichtung ändern

script_dir=$(bashio::config 'script_dir')
if [ ! -d "$script_dir" ]; then
  bashio::log.info "Creating script directory '${script_dir}' ..."
  mkdir -v -p $script_dir
else
  bashio::log.info "Found script directory '${script_dir}'."
fi

if ls ${script_dir}/*.lftp &>/dev/null; then
  bashio::log.info "Found lftp scripts in the script directory."
else
  bashio::log.info "Creating default lftp script in the script directory ..."
  tempio \
    -conf /data/options.json \
    -template /usr/share/tempio/default_script.gtpl \
    -out $script_dir/default_script.lftp
fi

shopt -s nullglob
for lftp_file in $script_dir/*.lftp; do
  bashio::log.info "Starting the lftp script '${lftp_file}' ..."
  lftp -f "${lftp_file}"
done

bashio::log.info "=== addon end ==="
bashio::exit.ok
