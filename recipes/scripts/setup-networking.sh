#!/bin/bash
set -e
hostname=${1:?'hostname is required'}

echo "$hostname" > /etc/hostname
# Generate /etc/hosts
cat <<EOF > /etc/hosts
127.0.0.1       localhost
127.0.1.1       ${hostname}

# The following lines are desirable for IPv6 capable hosts
::1     localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
EOF

# Network management
systemctl enable systemd-networkd
# DNS resolving
systemctl enable systemd-resolved

# netplan (if installed)
command -v netplan && netplan apply || true
