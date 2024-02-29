#!/usr/bin/with-contenv bashio
readonly config_dir="/config"
readonly run_dir="/config/run"
readonly log_dir="/config/log"
readonly config_file="$config_dir/rsyncd.conf"
readonly template_file="/etc/templates/rsyncd.conf.templ"

bashio::log.info "Ensure directory $config_dir exists ..."
mkdir -v -p $config_dir
chmod -R 755 $config_dir

bashio::log.info "Ensure directory $run_dir exists ..."
mkdir -v -p $run_dir
chmod -R 755 $run_dir

bashio::log.info "Ensure directory $log_dir exists ..."
mkdir -v -p $log_dir
chmod -R 755 $log_dir

bashio::log.info "Check if file $config_file exists ..."
if ! bashio::fs.file_exists "$config_file"; then
  bashio::log.info "Creating new rsyncd.conf ..."
  cp -v $template_file $config_file
  bashio::log.info "rsyncd.conf created."
else
  bashio::log.info "rsyncd.conf found."
fi
