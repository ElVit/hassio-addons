#!/usr/bin/with-contenv bashio
# ==============================================================================
# Prepare the Samba service for running
# ==============================================================================

readonly config_dir="/config"
readonly log_dir="$config_dir/log"
readonly lighttpd_file="$config_dir/lighttpd.conf"
readonly lighttpd_template=/etc/templates/lighttpd.conf.templ
readonly webdav_file="$config_dir/webdav.conf"
readonly webdav_template=/etc/templates/webdav.conf.templ


bashio::log.info "Show lighttpd version ..."
lighttpd -v

if ! bashio::config.has_value 'logins[0].username' || \
    ! bashio::config.has_value 'logins[0].password'; then
  bashio::exit.nok "No username or password is defined!"
fi

bashio::log.info "Ensure directory $config_dir/ exists ..."
mkdir -v -p $config_dir
chmod -R 755 $config_dir

bashio::log.info "Ensure directory $log_dir/ exists ..."
mkdir -v -p $log_dir
chmod -R 755 $log_dir

root_dir=$(bashio::config "document_root")
bashio::log.info "Ensure directory $root_dir/ exists ..."
mkdir -v -p $root_dir
chmod -R 755 $root_dir

if bashio::config.true 'custom_config'; then
  bashio::log.info "Check if file '$lighttpd_file' exists ..."
  if ! bashio::fs.file_exists "$lighttpd_file"; then
    bashio::log.info "Creating lighttpd.conf ..."
    tempio \
      -conf /data/options.json \
      -template $lighttpd_template  \
      -out $lighttpd_file
    bashio::log.info "lighttpd.conf created."
  else
    bashio::log.info "lighttpd.conf found."
  fi

  bashio::log.info "Check if file '$webdav_file' exists ..."
  if ! bashio::fs.file_exists "$webdav_file"; then
    bashio::log.info "Creating webdav.conf ..."
    tempio \
      -conf /data/options.json \
      -template $webdav_template  \
      -out $webdav_file
    bashio::log.info "webdav.conf created."
  else
    bashio::log.info "webdav.conf found."
  fi
else
  bashio::log.info "Creating lighttpd.conf ..."
  tempio \
    -conf /data/options.json \
    -template $lighttpd_template  \
    -out /etc/lighttpd/lighttpd.conf
  bashio::log.info "lighttpd.conf created."
  bashio::log.info "Creating webdav.conf ..."
  tempio \
    -conf /data/options.json \
    -template $webdav_template  \
    -out /etc/lighttpd/webdav.conf
  bashio::log.info "webdav.conf created."
fi

bashio::log.info "Adding user group 'webdav' ..."
addgroup "webdav"

bashio::log.info "Adding users and passwords ..."
# Add users and passwords to htpasswd file
for id in $(bashio::config 'logins|keys'); do
  bashio::config.require.username "logins[${id}].username"
  bashio::config.require.password "logins[${id}].password"
  username=$(bashio::config "logins[${id}].username")
  password=$(bashio::config "logins[${id}].password")

  adduser -D -H -G "webdav" -s /bin/false "${username}"
  htpasswd -b /etc/lighttpd/.htpasswd "${username}" "${password}" > /dev/null 2>&1
done
