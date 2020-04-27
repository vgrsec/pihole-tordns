#!/bin/bash
#
### VGR - PiHole & TorDNS
#
### Install DNSCrypt-Proxy & TOR
#
### Changelog ###
#
# 20200426 - Wrote Script

# Install DNSCrypt-Proxy
apt-get install dnscrypt-proxy -y

# Copy Socket File
# This changes the listening port from 53 to 8053
cp ./dnscrypt-configs/dnscrypt-proxy.socket  /etc/systemd/system/sockets.target.wants/dnscrypt-proxy.socket

# Copy dnscrypt config
cp ./dnscrypt-configs/zzz_dnscrypt-proxy.toml  /etc/dnscrypt-proxy/dnscrypt-proxy.toml

# Reload SystemD because existence is pain 
systemctl daemon-reload
systemctl restart dnscrypt-proxy

# Replace DNS with DNSCrypt
sed -i -E "s/PIHOLE_DNS_1=9.9.9.9/PIHOLE_DNS_1=127.0.0.1#8053/g" /etc/pihole/setupVars.conf

# Restart pihole service
systemctl restart pihole-FTL