#!/usr/bin/with-contenv bashio
# ==============================================================================
# Prepare the Netatalk service for running
# ==============================================================================
declare password
declare username
declare interface
export HOSTNAME

# Check Login data
if ! bashio::config.has_value 'username' || ! bashio::config.has_value 'password'; then
  bashio::exit.nok "Setting a username and password is required!"
fi

# Read hostname from API or setting default "hassio"
HOSTNAME=$(bashio::info.hostname)
if bashio::var.is_empty "${HOSTNAME}"; then
  bashio::log.warning "Can't read hostname, using default."
  HOSTNAME="hassio"
fi

# Get default interface
interface=$(bashio::network.name)
bashio::log.info "Using hostname=${HOSTNAME} interface=${interface}"

# Create Netatalk file directories
bashio::log.info "Creating group: netatalk-files"
addgroup --gid 9934 netatalk-files
if [ ! -d /share/afp/share ]; then
  mkdir -p /share/afp/share
  bashio::log.info "Created /share/afp/share"
fi
chgrp netatalk-files /share/afp/share
chmod g+rwx /share/afp/share
if [ ! -d /share/afp/timemachine ]; then
  mkdir -p /share/afp/timemachine
  bashio::log.info "Created /share/afp/timemachine"
fi
chgrp netatalk-files /share/afp/timemachine
chmod g+rwx /share/afp/timemachine

# Generate Netatalk configuration
mkdir -p /etc/netatalk
# touch /etc/netatalk/afp.conf
jq ".interface = \"${interface}\"" /data/options.json \
  | tempio \
    -template /usr/share/tempio/afp.gtpl \
    -out /etc/netatalk/afp.conf

# Init user
username=$(bashio::config 'username')
password=$(bashio::config 'password')
bashio::log.info "Creating user: ${username}"

adduser -D -H -G "netatalk-files" -s /bin/false "${username}"
# shellcheck disable=SC1117
echo "${username}:${password}" | chpasswd
afppasswd -c -p /etc/netatalk/afppasswd
# (echo $password; echo $password ) | afppasswd -f -a $username
# echo -e "${password}\n${password}" | afppasswd -f -a "${username}"

#exec netatalk -d