#!/usr/bin/with-contenv bashio
# ==============================================================================
# Prepare traefik for running
# ==============================================================================

readonly config_dir="/config"
readonly dynamic_file="$config_dir/dynamic.yaml"
readonly static_file="$config_dir/traefik.yaml"
readonly ssl_dir="/ssl/traefik"
readonly traefik_dir="/etc/traefik"

bashio::log.info "Check if directory $ssl_dir exists ..."
if [ ! -d "$ssl_dir" ]; then
  bashio::log.info "Creating $ssl_dir"
  mkdir -v -p $ssl_dir
  chmod 777 $ssl_dir
fi

bashio::log.info "Check if directory $config_dir exists ..."
if [ ! -d "$config_dir" ]; then
  bashio::log.info "Creating $config_dir"
  mkdir -v -p $config_dir
  chmod 777 $config_dir
fi

bashio::log.info "Check if file $dynamic_file exists ..."
if [ ! -f "$dynamic_file" ]; then
  bashio::log.info "Creating dynamic.yaml ..."
  cp -v /etc/templates/dynamic.yaml.gotmpl $dynamic_file
else
  bashio::log.info "dynamic.yaml found."
fi

bashio::log.info "Check if directory $traefik_dir exists ..."
if [ ! -d "$traefik_dir" ]; then
  bashio::log.info "Creating $traefik_dir"
  mkdir -v -p $traefik_dir
  chmod 777 $traefik_dir
fi

if bashio::config.true 'custom_static_config'; then
  bashio::log.info "Check if file $static_file exists ..."
  if [ ! -f "$static_file" ]; then
    bashio::log.info "Creating traefik.yaml ..."
    gomplate \
      --file /etc/templates/traefik.yaml.gotmpl \
      --datasource options=/data/options.json \
      --out $static_file
  else
    bashio::log.info "traefik.yaml found."
  fi

  bashio::log.info "Copying traefik.yaml to $traefik_dir ..."
  cp -v $static_file /etc/traefik/traefik.yaml
else
  bashio::log.info "Creating traefik.yaml ..."
  gomplate \
    --file /etc/templates/traefik.yaml.gotmpl \
    --datasource options=/data/options.json \
    --out /etc/traefik/traefik.yaml
fi
