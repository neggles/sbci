#!/bin/bash
set -e

hostname=${1:?'hostname is required'}

echo "$hostname" > /etc/hostname
echo -e "127.0.0.1\tlocalhost\t$hostname" > /etc/hosts
echo -e "127.0.1.1\t$hostname" >> /etc/hosts

# Network management
systemctl enable systemd-networkd
# DNS resolving
systemctl enable systemd-resolved
