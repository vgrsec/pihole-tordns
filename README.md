# pihole-tordns

AdBlock, Encryption, Anonymous

![DNS-Pihole-DoH-TOR](https://raw.githubusercontent.com/vgrsec/pihole-tordns/assets/dns-pihole-doh-tor.png)

## Overview

The goal of this project is to improve my house's DNS capabilities and to reduce my personal data emissions.

This provides an environment that blocks ads, runs DNS over HTTPS, and connects to DNS servers via TOR to mask the origin of DNS requests. 

### Pi-hole 

*The Pi-hole is a DNS sinkhole that protects your devices from unwanted content, without installing any client-side software.*

https://github.com/pi-hole/pi-hole/

### DNSCrypt-Proxy

*A flexible DNS proxy, with support for encrypted DNS protocols.*

https://github.com/DNSCrypt/dnscrypt-proxy

### TOR

*Tor protects your privacy on the internet by hiding the connection between your Internet address and the services you use.*

https://gitweb.torproject.org/tor.git

## Setup

For a full description of how this all works, and videos of packet capture proving it works, check out www.vgrsec.com/post20200426.html

All of the worker scripts are documented, as is the DNSCrypt config file.

### setup.sh

This script is your click next to success. Git clone this repo, run this script, you're done.


## Tests

Query a site you've never been to. If you've been to boogieblocks before today, I want to talk to you about an INTERNET before time :D

`dig boogieblocks.com`

### zzz_setup-test-pihole.sh

This script will one click setup Pi-hole clean. I used this to test packet capture DNS in the clear.

![DNS-Pihole](https://raw.githubusercontent.com/vgrsec/pihole-tordns/assets/dns-pihole.png)

### zzz_setup-test-doh.sh

This script will one click setup Pi-hole and DNSCrypt-Proxy. I used this to test packet capture DNS over HTTPS.

![DNS-Pihole-DoH](https://raw.githubusercontent.com/vgrsec/pihole-tordns/assets/dns-pihole-doh.png)

## Thanks & Additional Resources

These resources helped me along the way

* https://blog.sean-wright.com/dns-with-pi-hole-dnscrypt/
* https://github.com/piskyscan/dns_over_tls_over_tor/blob/master/README.md
* https://github.com/pi-hole/pi-hole/wiki/DNSCrypt-2.0
* https://github.com/DNSCrypt/dnscrypt-proxy/blob/master/dnscrypt-proxy/example-dnscrypt-proxy.toml
* https://github.com/DNSCrypt/dnscrypt-proxy/wiki/DNS-server-sources
* https://dnscrypt.info/public-servers
