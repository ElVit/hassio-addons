#!/usr/bin/with-contenv bashio
# ==============================================================================
# Prepare the Samba service for running
# ==============================================================================

export HOSTNAME
declare username
declare password
declare -a interfaces=()
readonly config_dir="/config"
readonly config_file="$config_dir/smb.conf"
readonly config_template="/etc/templates/smb.conf.templ"


bashio::log.info "Using samba version:"
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

bashio::log.info "Ensure directory $config_dir exists ..."
mkdir -v -p $config_dir
chmod -R 755 $config_dir

if bashio::config.true 'custom_config'; then
  bashio::log.info "Check if file $config_file exists ..."
  if ! bashio::fs.file_exists "$config_file"; then
    bashio::log.info "Creating new smb.conf ..."
    jq ".interfaces = $(jq -c -n '$ARGS.positional' --args -- "${interfaces[@]}")" /data/options.json | \
      tempio -template $config_template -out $config_file
    bashio::log.info "smb.conf created."
  else
    bashio::log.info "smb.conf found."
  fi
else
  bashio::log.info "Creating new smb.conf ..."
  jq ".interfaces = $(jq -c -n '$ARGS.positional' --args -- "${interfaces[@]}")" /data/options.json | \
    tempio -template $config_template -out /etc/samba/smb.conf
  bashio::log.info "smb.conf created."
fi

bashio::log.info "Adding user group 'samba-files' ..."
addgroup "samba-files"

bashio::log.info "Adding users and passwords ..."
for login in $(bashio::config 'logins|keys'); do
  bashio::config.require.username "logins[${login}].username"
  bashio::config.require.password "logins[${login}].password"
  username=$(bashio::config "logins[${login}].username")
  password=$(bashio::config "logins[${login}].password")

  adduser -D -H -G "samba-files" -s /bin/false "${username}"
  # shellcheck disable=SC1117
  echo -e "${password}\n${password}" | \
    smbpasswd -a -s -c "/etc/samba/smb.conf" "${username}"
done


