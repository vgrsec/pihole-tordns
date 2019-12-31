#!/bin/bash
#
### vgrsec
#
### Changelog
# 20191230 - initial 
#

# Install Docker https://docs.docker.com/install/linux/docker-ce/ubuntu/
sudo apt-get update
sudo apt-get upgrade -y 
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common \
    -y 

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update
sudo apt-get install \
	docker-ce \
	docker-ce-cli \
	containerd.io \
	-y

sudo docker run hello-world

# Install Docker Compose https://docs.docker.com/compose/install/
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

# Create the Pi-Tor-DNS Docker Network
sudo docker network create pitornetwork

# git clone https://github.com/piskyscan/dns_over_tls_over_tor.git
# git clone https://github.com/PeterDaveHello/tor-socks-proxy.git

# Bug in Dockerfile
sed -i -e 's/libyaml-dev/apt-utils\ libyaml-dev/g' ./dns_over_tls_over_tor/Dockerfile

# Stop Ubuntu 18.04 from listening on 53
sudo sed -i -e 's/127.0.0.53/127.0.0.1/g' /etc/resolv.conf
sudo sed -i -e '$ a\DNSStubListener=no' /etc/systemd/resolved.conf
sudo systemctl daemon-reload
sudo systemctl restart systemd-resolved.service

# https://github.com/hsaito/docker-torbox

cd pihole
# sudo docker-compose up  --force-recreate --detach
cd ..
cd tor-socks-proxy 
sudo docker build --no-cache -t tor-socks-proxy .
# sudo docker run --name tor --network pitornetwork --ip 172.18.0.21 -d tor:latest
cd ..
cd dns_over_tls_over_tor 
sudo docker build --no-cache -t dns_over_tls_over_tor .
# sudo docker run --name tordns --network pitornetwork --ip 172.18.0.22 -d dns_over_tls_over_tor:latest


