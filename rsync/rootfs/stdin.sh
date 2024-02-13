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

  re='^[0-9]+$'
  if ! [[ $input =~ $re ]]; then
      bashio::log.error "STDIN is not a positive number."
      continue
  fi
  if [ "$input" -ge "$cmd_count" ]; then
      bashio::log.error "Command index is greater than the count of rsync commands."
      continue
  fi

  bashio::log.info "Executing rsync command at index: ${input}"
  command=$(echo "$commands" | jq -r ".[$input]")
  bashio::log.info "$command"
  eval "rsync $command"
done
