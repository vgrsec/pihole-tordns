#!/bin/bash
#
### VGR - PiHole & TorDNS
#
### Install DNSCrypt-Proxy & TOR
#
### Changelog ###
#
# 20200426 - Wrote Script

# Install DNSCrypt-Proxy & TOR
apt-get install tor -y 
apt-get install dnscrypt-proxy -y

# Copy Socket File
# This changes the listening port from 53 to 8053
cp ./dnscrypt-configs/dnscrypt-proxy.socket  /etc/systemd/system/sockets.target.wants/dnscrypt-proxy.socket

# Copy dnscrypt config
cp ./dnscrypt-configs/dnscrypt-proxy.toml  /etc/dnscrypt-proxy/dnscrypt-proxy.toml

systemctl daemon-reload
systemctl restart dnscrypt-proxy