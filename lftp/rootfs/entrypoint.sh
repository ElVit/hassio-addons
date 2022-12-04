#!/usr/bin/with-contenv bashio
# ==============================================================================
# Script for starting the lftp scripts
# ==============================================================================
declare scriptDir
declare filesCount
declare filePath
declare credentials
declare machine
declare login
declare password

bashio::log.info "=== addon start ==="
bashio::log.info "Using LFTP version:"
lftp --version

scriptDir=$(bashio::config 'script_dir')
bashio::log.info "Ensuring script directory '${scriptDir}' exists ..."
mkdir -v -p $scriptDir

filesCount=$(find $scriptDir -type f -name "*.lftp" | wc -l)
bashio::log.info "Found ${filesCount} lftp script(s) in the script directory."

if [ "$filesCount" -eq 0 ]; then
  bashio::log.info "Creating default lftp script in the script directory ..."
  tempio \
    -conf /data/options.json \
    -template /etc/templates/script.lftp.gtpl \
    -out $scriptDir/script.lftp
  bashio::log.warning "Please edit the newly created file '${scriptDir}/script.lftp' and start this addon again."
  bashio::exit.nok
fi

bashio::log.info "Setting up .netrc ..."
credentials=$(bashio::config 'credentials')
for credential in ${credentials}; do
  machine=$(bashio::jq "${credential}" ".url")
  login=$(bashio::jq "${credential}" ".username")
  password=$(bashio::jq "${credential}" ".password")
  bashio::log.info "Adding machine '${machine}' with login '${login}' ..."
  printf "machine %s login %s password %s\n" $machine $login $password >> /root/.netrc
done

shopt -s nullglob
for filePath in ${scriptDir}/*.lftp; do
  bashio::log.info "Starting the lftp script '${filePath}' ..."

  # added '|| true' so the next scripts will be executed
  lftp -f "${filePath}" || true

  bashio::log.info "Lftp script '${filePath}' finished."
done

bashio::log.info "=== addon end ==="
bashio::exit.ok
