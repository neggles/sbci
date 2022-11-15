#!/usr/bin/env bash
set -e
# Network management
systemctl enable systemd-networkd
# DNS resolving
systemctl enable systemd-resolved
