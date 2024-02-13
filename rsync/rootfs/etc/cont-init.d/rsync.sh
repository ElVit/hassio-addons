#!/usr/bin/with-contenv bashio
readonly config_dir="/config"
readonly run_dir="/config/run"
readonly log_dir="/config/log"
readonly config_file="$config_dir/rsyncd.conf"

bashio::log.info "Check if directory $config_dir exists ..."
if ! bashio::fs.directory_exists "$config_dir"; then
#if [ ! -d "$config_dir" ]; then
  bashio::log.info "Creating $config_dir"
  mkdir -v -p $config_dir
  chmod 777 $config_dir
fi
bashio::log.info "Check if directory $run_dir exists ..."
if ! bashio::fs.directory_exists "$run_dir"; then
#if [ ! -d "$run_dir" ]; then
  bashio::log.info "Creating $run_dir"
  mkdir -v -p $run_dir
  chmod 777 $run_dir
fi
bashio::log.info "Check if directory $log_dir exists ..."
if ! bashio::fs.directory_exists "$log_dir"; then
#if [ ! -d "$log_dir" ]; then
  bashio::log.info "Creating $log_dir"
  mkdir -v -p $log_dir
  chmod 777 $log_dir
fi

bashio::log.info "Check if file $config_file exists ..."
if ! bashio::fs.file_exists "$config_file"; then
#if [ ! -f "$config_file" ]; then
  bashio::log.info "Creating new rsyncd.conf ..."
  cp -v /etc/templates/rsyncd.conf.tmpl $config_file
  bashio::log.info "rsyncd.conf created."
else
  bashio::log.info "rsyncd.conf found."
fi

bashio::log.info "Copying rsyncd.conf to /etc ..."
cp -v $config_file /etc/rsyncd.conf



# for id in $(bashio::config 'folders|keys'); do
#   local=$(bashio::config "folders[${id}].source")
#   remote=$(bashio::config "folders[${id}].destination")
#   options=$(bashio::config "folders[${id}].options")
#   if ! bashio::config.has_value "folders[${id}].options"; then
#     options="--archive --recursive --compress --delete --prune-empty-dirs"
#   fi

#   bashio::log.info "Sync ${local} -> ${remote} with options \"${options}\""
#   # set -x
#   # shellcheck disable=SC2086
#   rsync ${options} "${local}" "${remote}"
#   # set +x
# done

# bashio::log.info "Synced all folders"
