#!/usr/bin/with-contenv bashio
# ==============================================================================
# Prepare the Samba service for running
# ==============================================================================
declare password
declare username
declare interface
declare config_dir
export HOSTNAME

# Check Login data
if ! bashio::config.has_value 'logins[0].username' || ! bashio::config.has_value 'logins[0].password'; then
    bashio::exit.nok "Setting a username and password is required!"
fi

config_dir=$(bashio::config 'config_dir')
if [ ! -d "$config_dir" ]; then
  bashio::log.info "Creating config_dir '${config_dir}' ..."
  mkdir -p $config_dir
fi

if [ ! -f "$config_dir/smb.conf" ]; then
  # Read hostname from API or setting default "hassio"
  HOSTNAME=$(bashio::info.hostname)
  if bashio::var.is_empty "${HOSTNAME}"; then
    bashio::log.warning "Can't read hostname, using default."
    HOSTNAME="hassio"
  fi
  
  # Get default interface
  interface=$(bashio::network.name)
  bashio::log.info "Using hostname=${HOSTNAME} interface=${interface}"

  # Generate Samba configuration.
  bashio::log.info "Creating default smb.conf in config_dir ..."
  jq ".interface = \"${interface}\"" /data/options.json \
    | tempio \
      -template /usr/share/tempio/smb.gtpl \
      -out $config_dir/smb.conf
else
  bashio::log.info "Found smb.conf in config_dir."
fi

bashio::log.info "Copying user edited smb.conf to /etc/samba/smb.conf ..."
cp -v $config_dir/smb.conf /etc/samba/smb.conf

bashio::log.info "Creating user group 'samba-files' ..."
addgroup "samba-files"

# Set username and password
for login in $(bashio::config 'logins|keys'); do
  bashio::config.require.username "logins[${login}].username"
  bashio::config.require.password "logins[${login}].password"
  username=$(bashio::config "logins[${login}].username")
  password=$(bashio::config "logins[${login}].password")

  bashio::log.info "Setting up user '${username}' ..."
  adduser -D -H -G "samba-files" -s /bin/false "${username}"
  # shellcheck disable=SC1117
  echo -e "${password}\n${password}" | smbpasswd -a -s -c "/etc/samba/smb.conf" "${username}"
done
