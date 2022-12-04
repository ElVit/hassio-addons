#!/usr/bin/with-contenv bashio
# ==============================================================================
# Prepare traefik for running
# ==============================================================================

declare config_dir

bashio::log.info "Ensuring SSL directory exists ..."
mkdir -v -p /ssl/traefik/

bashio::log.info "Ensuring directory for dynamic config exists ..."
config_dir=$(bashio::config 'dir_of_dynamic_config')
mkdir -v -p $config_dir

bashio::log.info "Check if dynamic config exists ..."
if [ ! -f "$config_dir/dynamic.yaml" ]; then
  bashio::log.info "Creating dynamic config ..."
  cp -v /etc/templates/dynamic.yaml $config_dir/dynamic.yaml
else
  bashio::log.info "dynamic.yaml found."
fi

if bashio::config.true 'custom_static_config'; then
  if ! bashio::config.has_value 'dir_of_static_config'; then
    bashio::exit.nok 'No directory for static config defined.'
  fi

  bashio::log.info "Ensuring directory for static config exists ..."
  mkdir -v -p /etc/traefik/
  config_dir=$(bashio::config 'dir_of_static_config')
  mkdir -v -p $config_dir

  bashio::log.info "Check if static config exists ..."
  if [ ! -f "$config_dir/traefik.yaml" ]; then
    bashio::log.info "Creating static config ..."
    gomplate \
      --file /etc/templates/traefik.yaml.gotmpl \
      --datasource options=/data/options.json \
      --out $config_dir/traefik.yaml
  else
    bashio::log.info "traefik.yaml found."
  fi
  
  bashio::log.info "Copying traefik.yaml to /etc/traefik/traefik.yaml ..."
  mkdir -v -p /etc/traefik/
  cp -v $config_dir/traefik.yaml /etc/traefik/traefik.yaml
else
  bashio::log.info "Creating static config ..."
  mkdir -v -p /etc/traefik/
  gomplate \
    --file /etc/templates/traefik.yaml.gotmpl \
    --datasource options=/data/options.json \
    --out /etc/traefik/traefik.yaml
fi
