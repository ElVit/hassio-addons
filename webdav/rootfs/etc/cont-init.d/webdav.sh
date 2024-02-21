#!/usr/bin/with-contenv bashio
# ==============================================================================
# Prepare the Samba service for running
# ==============================================================================

if ! bashio::config.has_value 'users[0].username' || \
    ! bashio::config.has_value 'users[0].password'; then
  bashio::exit.nok "No username or password is defined!"
fi

bashio::log.info "Ensuring ssl directory exists ..."
mkdir -p /ssl/webdav/
bashio::log.info "Ensuring data directory exists ..."
mkdir -p /config/data/

bashio::log.info "Generating webdav.yaml ..."
gomplate -f /etc/templates/webdav.yaml.gotmpl -d options=/data/options.json -o /config/webdav.yaml
bashio::log.info "webdav.yaml generated"
