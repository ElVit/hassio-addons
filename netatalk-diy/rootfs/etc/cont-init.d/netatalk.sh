#!/usr/bin/with-contenv bashio
# ==============================================================================
# Prepare the Netatalk service for running
# ==============================================================================
declare username
declare password
declare config_dir
declare netatalk_share_dir
declare timemachine_dir
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
bashio::log.info "Using hostname=${HOSTNAME}"

# Create Netatalk file directories
bashio::log.info "Creating group 'netatalk-files' ..."
addgroup --gid 9934 netatalk-files

netatalk_share_dir=$(bashio::config 'netatalk_share_dir')
if [ ! -d "$netatalk_share_dir" ]; then
  bashio::log.info "Creating netatalk share directory '${netatalk_share_dir}' ..."
  mkdir -p $netatalk_share_dir
fi
chgrp netatalk-files $netatalk_share_dir
chmod g+rwx $netatalk_share_dir

timemachine_dir=$(bashio::config 'timemachine_dir')
if [ ! -d "$timemachine_dir" ]; then
  bashio::log.info "Creating timemachine directory '${timemachine_dir}' ..."
  mkdir -p $timemachine_dir
fi
chgrp netatalk-files $timemachine_dir
chmod g+rwx $timemachine_dir

config_dir=$(bashio::config 'config_dir')
if [ ! -d "$config_dir" ]; then
  bashio::log.info "Creating config directory '${config_dir}' ..."
  mkdir -p $config_dir
fi

if [ ! -f "$config_dir/afp.conf" ]; then
  bashio::log.info "Creating default afp.conf in config directory ..."
  tempio \
    -conf /data/options.json \
    -template /usr/share/tempio/afp.gtpl \
    -out $config_dir/afp.conf
  #cp /usr/share/templates/afp.conf $config_dir
  #jq /data/options.json | tempio \
      #-template /usr/share/templates/afp.gtpl \
      #-out $config_dir/afp.conf
  #gomplate -f /usr/share/templates/afp.gotmpl \
  #-d options=/data/options.json \
  #-o "${config_dir}/afp.conf"
else
  bashio::log.info "Found afp.conf in config directory."
fi

bashio::log.info "Copying user edited afp.conf to /etc/afp.conf ..."
cp -v $config_dir/afp.conf /etc/afp.conf

username=$(bashio::config 'username')
password=$(bashio::config 'password')

bashio::log.info "Creating user '${username}' ..."
adduser -D -H -G "netatalk-files" -s /bin/false "${username}"
# shellcheck disable=SC1117
echo "${username}:${password}" | chpasswd
afppasswd -c
# (echo $password; echo $password ) | afppasswd -f -a $username
# echo -e "${password}\n${password}" | afppasswd -f -a "${username}"

# bashio::log.info "Start dbus ..."
# mkdir -p /var/run/dbus
# rm -f /var/run/dbus/pid
# dbus-daemon --system

# bashio::log.info "Start avahi ..."
# sed -i '/rlimit-nproc/d' /etc/avahi/avahi-daemon.conf
# avahi-daemon -D

# sed -i 's/#enable-dbus=.*/enable-dbus=no/g' /etc/avahi/avahi-daemon.conf

# mkdir -p /external/avahi \
# echo ">> EXTERNAL AVAHI: found external avahi, now maintaining avahi service file 'afp.service'"
# echo ">> EXTERNAL AVAHI: internal avahi gets disabled"
# rm -rf /container/config/runit/avahi
# cp /etc/avahi/services/afp.service /external/avahi/afp.service
# chmod a+rw /external/avahi/afp.service
# echo ">> EXTERNAL AVAHI: list of services"
# ls -l /external/avahi/*.service

# bashio::log.info "--- Netatalk version ---"
# netatalk -V
