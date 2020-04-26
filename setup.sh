#!/bin/bash
#
### VGR - PiHole & TorDNS
#
### Changelog ###
#
# 20200426 - Wrote Script

# This ensures the script runs with sudo.
 
if (($EUID != 0)); then
  if [[ -t 1 ]]; then
    sudo "$0" "$@"
  else
    exec 1>output_file
    gksu "$0 $@"
  fi
  exit
fi

# Update everything.
apt-get update
apt-get upgrade -y

# It's assumed here we're running this on 
# a clean install of Ubuntu 20.04

PIHOLE="./setup-pihole.sh"
./ "$PIHOLE"

TORDNS="./setup-tor-dns.sh"
./ "$TORNDS"

