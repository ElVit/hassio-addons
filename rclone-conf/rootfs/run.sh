#!/usr/bin/with-contenv bashio
# ==============================================================================
# Script for starting rclone
# ==============================================================================
declare configPath
declare jobs
declare name
declare source
declare destination
declare commands

configPath=$(bashio::config 'config_file')
configDir="$(dirname "${configPath}")"

if [ ! -d "$configDir" ]; then
  bashio::log.info "Creating config directory '${configDir}' ..."
  mkdir -v -p $configDir
fi

if [ ! -f "$configPath" ]; then
  bashio::log.info "Creating config file '${configPath}' ..."
  cp -v /usr/share/template/rclone.conf $configPath
  bashio::log.warning "Please edit the newly created file '${configPath}' and start this addon again."
  bashio::log.info "=== addon end ==="
  bashio::exit.ok
fi

bashio::log.info "Copy user edited config file to /root/.config/rclone/rclone.conf ..."
mkdir -p /root/.config/rclone
cp -v $configPath /root/.config/rclone/rclone.conf

for jobId in $(bashio::config 'jobs|keys'); do
  name=$(bashio::config "jobs[${jobId}].name")
  commands=$(bashio::config "jobs[${jobId}].commands")
  source=$(bashio::config "jobs[${jobId}].source")
  destination=$(bashio::config "jobs[${jobId}].destination")

  bashio::log.info "Files/folders in source location '${source}':"
  rclone lsd ${source}
  bashio::log.info "Files/folders in destination location '${destination}':"
  rclone lsd ${destination}

  bashio::log.info "Starting rsync job '${name}'..."
  rclone ${commands} ${source} ${destination}
  bashio::log.info "Completed rsync job '${name}''."
done

bashio::log.info "=== addon end ==="
bashio::exit.ok
