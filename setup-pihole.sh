#!/bin/bash
#
### VGR - PiHole & TorDNS
#
### Silent Install PiHole
#
### Changelog ###
#
# 20200426 - Wrote Script


# Create pihole preconfigured configuration

# PiHole needs interface and IP information from the system
# These two actions come directly from the basic install script from PiHole
# https://github.com/pi-hole/pi-hole/blob/master/automated%20install/basic-install.sh
IPV4_ADDRESS=$(ip -oneline -family inet address show | grep "${IPv4bare}/" |  awk '{print $4}' | awk 'END {print}')
PIHOLE_INTERFACE=$(ip link | awk -F: '$0 !~ "lo|vir|tun|wl|^[^0-9]"{print $2;getline}')

echo "is " $IPV4_ADDRESS "a static ip address? If not STOP and make it static"

# This is the unattended configuration file used to automate install
# It's set to default no web password and a dns provider
# Deal with it.

touch setupVars.conf
cat << EOF >> setupVars.conf
PIHOLE_INTERFACE=$PIHOLE_INTERFACE
IPV4_ADDRESS=$IPV4_ADDRESS
QUERY_LOGGING=true
INSTALL_WEB_SERVER=true
INSTALL_WEB_INTERFACE=true
LIGHTTPD_ENABLED=true
BLOCKING_ENABLED=true
WEBPASSWORD=
DNSMASQ_LISTENING=single
PIHOLE_DNS_1=9.9.9.9
DNS_FQDN_REQUIRED=true
DNS_BOGUS_PRIV=true
DNSSEC=false
CONDITIONAL_FORWARDING=false
EOF

sed -i -E "s/ //g" setupVars.conf
mkdir /etc/pihole
mv ./setupVars.conf /etc/pihole/setupVars.conf

# Download and Install PiHole

wget -O basic-install.sh https://install.pi-hole.net
chmod +x ./basic-install.sh

./basic-install.sh --unattended