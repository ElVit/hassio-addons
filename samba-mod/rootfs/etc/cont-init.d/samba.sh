#!/usr/bin/with-contenv bashio
# ==============================================================================
# Prepare the Samba service for running
# ==============================================================================
declare username
declare password
declare config_dir
declare interface
export HOSTNAME

# Check Login data
if ! bashio::config.has_value 'logins[0].username' || ! bashio::config.has_value 'logins[0].password'; then
  bashio::exit.nok "Setting a username and password is required!"
fi

# Check if config_dir exists
config_dir=$(bashio::config 'config_dir')
if [ ! -d "$config_dir" ]; then
  bashio::log.info "Creating config directory '${config_dir}' ..."
  mkdir -p $config_dir
fi

# Check if smb.conf exists in config_dir
if [ ! -f "$config_dir/smb.conf" ]; then
  # Read hostname from API or setting default "hassio"
  HOSTNAME=$(bashio::info.hostname)
  if bashio::var.is_empty "${HOSTNAME}"; then
    bashio::log.warning "Can't read hostname, using default."
    HOSTNAME="hassio"
  fi
  bashio::log.info "Using hostname '${HOSTNAME}'"

  # Get default interface
  interface=$(bashio::network.name)
  bashio::log.info "Using interface '${interface}'"

  # Generate samba configuration
  bashio::log.info "Creating default smb.conf in config directory ..."
  jq ".interface = \"${interface}\"" /data/options.json \
    | tempio \
      -template /usr/share/tempio/smb.gtpl \
      -out $config_dir/smb.conf
else
  bashio::log.info "Found smb.conf in config directory."
fi

# Copy user edited smb.conf to to the directory where it will be used
bashio::log.info "Copying user edited smb.conf to /etc/samba/smb.conf ..."
cp -v $config_dir/smb.conf /etc/samba/smb.conf

# Creating a group for all samba user
bashio::log.info "Creating user group 'samba-files' ..."
addgroup "samba-files"

# Setup users
for login in $(bashio::config 'logins|keys'); do
  bashio::config.require.username "logins[${login}].username"
  bashio::config.require.password "logins[${login}].password"
  username=$(bashio::config "logins[${login}].username")
  password=$(bashio::config "logins[${login}].password")

  bashio::log.info "Creating user '${username}' ..."
  adduser -D -H -G "samba-files" -s /bin/false "${username}"
  # shellcheck disable=SC1117
  echo -e "${password}\n${password}" | smbpasswd -a -s -c "/etc/samba/smb.conf" "${username}"
done
