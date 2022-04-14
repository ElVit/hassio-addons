#!/usr/bin/with-contenv bashio
# ==============================================================================
# Prepare the Samba service for running
# ==============================================================================
declare password
declare username
declare interface
export HOSTNAME

# ToDo: 1. Aus dem Template wird eine smb.conf erstellt und nach /share/samba/ kopiert
#       2. Wenn smb.conf schon existiert entfällt Schritt 1.
#       3. smb.conf wird nach /etc/samba/smb.conf kopiert
#       4. Benutzer werden bei jedem start des Addons angelegt
# Fragen: Brauche ich addgroup ? Vielleicht reicht nur adduser.

# Check Login data
if ! bashio::config.has_value 'logins[0].username' || ! bashio::config.has_value 'logins[0].password'; then
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

# # Generate Samba configuration.
# jq ".interface = \"${interface}\"" /data/options.json \
#     | tempio \
#       -template /usr/share/tempio/smb.gtpl \
#       -out /etc/samba/smb.conf

# TODO: Copy smb.conf from /config/addons_config/samba/

addgroup "samba-files"

# Set username and password
for login in $(bashio::config 'logins|keys'); do
  bashio::config.require.username "logins[${login}].username"
  bashio::config.require.password "logins[${login}].password"
  username=$(bashio::config "logins[${login}].username")
  password=$(bashio::config "logins[${login}].password")

  bashio::log.info "Setting up user ${username}"
  adduser -D -H -G "samba-files" -s /bin/false "${username}"
  # shellcheck disable=SC1117
  echo -e "${password}\n${password}" | smbpasswd -a -s -c "/etc/samba/smb.conf" "${username}"
done