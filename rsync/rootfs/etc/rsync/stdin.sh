#!/usr/bin/with-contenv bashio
# shellcheck shell=bash
declare commands
declare cmd_count

bashio::log.info 'Available rsync connections defined in rsyncd.conf:'
rsync rsync://localhost

# get all rsync commands from the addon config
commands=$(bashio::addon.config | jq -r ".rsync_commands")
cmd_count=$(echo "$commands" | jq -r '. | length')
bashio::log.info "Count of rsync commands: $cmd_count"

bashio::log.info 'Starting the STDIN service for Home Assistant...'
# shellcheck disable=SC2162
while read -r input; do
  # Parse JSON value
  input=$(bashio::jq "${input}" '.')
  bashio::log.info "STDIN: ${input}"
  
  if ! [[ $input =~ ^[0-9]+$ ]]; then
      bashio::log.warning "STDIN is not a positive number."
      continue
  fi

  if (( input < 1 )) || (( input > cmd_count )); then
      bashio::log.warning "STDIN is 0 or greater than the count of rsync commands."
      continue
  fi

  bashio::log.info "Executing rsync command No. ${input}."
  index="$((input - 1))"
  command=$(echo "$commands" | jq -r ".[$index]")
  bashio::log.info "$command"
  
  eval "rsync $command"
  
  bashio::log.info "Rsync command No. ${input} finished."
done
