#!/bin/bash

iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X

# Allow all and everything on localhost
iptables -A INPUT  -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# LAN just replace with local subnet
iptables -A INPUT  -i ens3 -s 192.168.1.0/24 -j ACCEPT
iptables -A OUTPUT -o ens3 -d 192.168.1.0/24 -j ACCEPT

# DNS
iptables -A INPUT  -p udp --sport 53 -j ACCEPT
iptables -A OUTPUT -p udp --dport 53 -j ACCEPT

# Allow VPN traffic
iptables -A INPUT  -p udp --sport 1194 -j ACCEPT
iptables -A OUTPUT -p udp --dport 1194 -j ACCEPT

# PIA DNS
iptables -A INPUT  -s 209.222.18.222 -j ACCEPT;
iptables -A OUTPUT -s 209.222.18.222 -j ACCEPT;

# PIA server
iptables -A INPUT  -p udp -s brazil.privateinternetaccess.com -j ACCEPT;
iptables -A OUTPUT -p udp -d brazil.privateinternetaccess.com -j ACCEPT;
#iptables -A INPUT  -p udp -s us-midwest.privateinternetaccess.com -j ACCEPT;
#iptables -A OUTPUT -p udp -d us-midwest.privateinternetaccess.com -j ACCEPT;
#iptables -A INPUT  -p udp -s ca-toronto.privateinternetaccess.com -j ACCEPT;
#iptables -A OUTPUT -p udp -d ca-toronto.privateinternetaccess.com -j ACCEPT;

# Accept TUN
iptables -A INPUT    -i tun+ -j ACCEPT
iptables -A OUTPUT   -o tun+ -j ACCEPT
iptables -A FORWARD  -i tun+ -j ACCEPT

# Drop the rest
iptables -A INPUT   -j DROP
iptables -A OUTPUT  -j DROP
iptables -A FORWARD -j DROP
