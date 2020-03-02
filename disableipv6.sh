#!/bin/bash

#Disables getting a local or default IPv6 address for debian/ubuntu
sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.lo.disable_ipv6=1
sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1

#Disable for VPN
#sudo sysctl -w net.ipv6.conf.tun0.disable_ipv6=1

echo "Displaying Interfaces"
echo 
ip -c a