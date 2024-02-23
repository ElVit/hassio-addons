#!/usr/bin/with-contenv bashio
# ==============================================================================
# Prepare the Samba service for running
# ==============================================================================

readonly templ_file="/etc/templates/config.yaml.tmpl"

bashio::log.info "Show webdav version:"
webdav version

bashio::log.info "Show webdav help:"
webdav help

bashio::log.info "Ensuring addon config directory exists ..."
mkdir -v -p /config/

config_file=$(bashio::config "config_file")
bashio::log.info "Ensuring file '$config_file' exists ..."
if ! bashio::fs.file_exists "$config_file"; then
  bashio::log.info "Creating config.yaml ..."
  cp -v $templ_file $config_file
else
  bashio::log.info "config.yaml found."
fi
