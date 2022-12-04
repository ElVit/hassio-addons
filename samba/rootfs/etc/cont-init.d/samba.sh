#!/usr/bin/with-contenv bashio
# ==============================================================================
# Prepare the Samba service for running
# ==============================================================================

declare username
declare password
declare config_dir
declare -a interface
export HOSTNAME

bashio::log.info "Using Smaba version:"
smbstatus --version

if ! bashio::config.has_value 'logins[0].username' || \
    ! bashio::config.has_value 'logins[0].password'; then
  bashio::exit.nok "No username or password is defined!"
fi

HOSTNAME=$(bashio::info.hostname)
if bashio::var.is_empty "${HOSTNAME}"; then
  bashio::log.warning "Can't read hostname, using default."
  HOSTNAME="homeassistant"
fi
bashio::log.info "Using hostname '${HOSTNAME}'."

for interface in $(bashio::network.interfaces); do
  interfaces+=("${interface}")
done
if [ ${#interfaces[@]} -eq 0 ]; then
  bashio::exit.nok 'No supported interfaces found to bind on.'
fi
bashio::log.info "Supported interfaces: $(printf '%s ' "${interfaces[@]}")"

if bashio::config.true 'custom_config'; then
  if ! bashio::config.has_value 'config_dir'; then
    bashio::exit.nok 'No config directory defined.'
  fi
  bashio::log.info "Ensuring config directory exists ..."
  config_dir=$(bashio::config 'config_dir')
  mkdir -v -p $config_dir

  if [ ! -f "$config_dir/smb.conf" ]; then
    bashio::log.info "Creating smb.conf ..."
    jq ".interfaces = $(jq -c -n '$ARGS.positional' --args -- "${interfaces[@]}")" /data/options.json | \
      tempio -template /etc/templates/smb.conf.gtpl -out $config_dir/smb.conf
    bashio::log.info "smb.conf created."
  else
    bashio::log.info "smb.conf found."
  fi

  bashio::log.info "Copying smb.conf to /etc/samba/smb.conf ..."
  cp -v $config_dir/smb.conf /etc/samba/smb.conf
else
  bashio::log.info "Creating smb.conf ..."
  jq ".interfaces = $(jq -c -n '$ARGS.positional' --args -- "${interfaces[@]}")" /data/options.json | \
    tempio -template /etc/templates/smb.conf.gtpl -out /etc/samba/smb.conf
  bashio::log.info "smb.conf created."
fi

bashio::log.info "Adding user group 'samba-files' ..."
addgroup "samba-files"

for login in $(bashio::config 'logins|keys'); do
  bashio::config.require.username "logins[${login}].username"
  bashio::config.require.password "logins[${login}].password"
  username=$(bashio::config "logins[${login}].username")
  password=$(bashio::config "logins[${login}].password")

  bashio::log.info "Adding user '${username}' ..."
  adduser -D -H -G "samba-files" -s /bin/false "${username}"
  # shellcheck disable=SC1117
  echo -e "${password}\n${password}" | \
    smbpasswd -a -s -c "/etc/samba/smb.conf" "${username}"
done
