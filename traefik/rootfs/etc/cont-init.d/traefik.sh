#!/usr/bin/with-contenv bashio
# ==============================================================================
# Prepare traefik for running
# ==============================================================================

readonly config_dir="/config"
readonly ssl_dir="/ssl/traefik"
readonly log_dir="$config_dir/log"
readonly static_file="$config_dir/traefik.yaml"
readonly dynamic_file="$config_dir/dynamic.yaml"
readonly static_template="/etc/templates/traefik.yaml.templ"
readonly dynamic_template="/etc/templates/dynamic.yaml.templ"


bashio::log.info "Ensuring directory '$ssl_dir' exists ..."
mkdir -v -p $ssl_dir/
chmod -R 600 $ssl_dir

bashio::log.info "Ensuring directory '$config_dir' exists ..."
mkdir -v -p $config_dir/
chmod -R 755 $config_dir

if bashio::config.true 'access_logs'; then
  bashio::log.info "Ensuring directory '$log_dir' exists ..."
  mkdir -v -p $log_dir/
  chmod -R 755 $log_dir
fi

bashio::log.info "Ensuring file '$dynamic_file' exists ..."
if ! bashio::fs.file_exists "$dynamic_file"; then
  cp -v $dynamic_template $dynamic_file
fi

if bashio::config.true "custom_config"; then
  bashio::log.info "Check if file '$static_file' exists ..."
  if ! bashio::fs.file_exists "$static_file"; then
    bashio::log.info "Creating traefik.yaml ..."
    tempio \
      -conf /data/options.json \
      -template $static_template \
      -out $static_file
    bashio::log.info "traefik.yaml created."
  else
    bashio::log.info "traefik.yaml found."
  fi
else
  bashio::log.info "Creating traefik.yaml ..."
  tempio \
    -conf /data/options.json \
    -template $static_template \
    -out /etc/traefik/traefik.yaml
  bashio::log.info "traefik.yaml created."
fi
