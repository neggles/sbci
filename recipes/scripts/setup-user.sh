#!/usr/bin/env bash
set -euo pipefail

username=${1:?'username is required'}
password=${2:?'password is required'}
uid=${3:-1000}

adduser --gecos admin --disabled-password --shell /bin/bash --uid ${uid} ${username}
adduser ${username} sudo,video,render,audio,bluetooth,plugdev,input,dialout

# set password and expire it to force a change on first login
echo "${username}:${password}" | chpasswd
passwd -e "${username}"

exit 0
