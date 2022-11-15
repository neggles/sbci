#!/usr/bin/env bash
set -euo pipefail

username=${1:?'username is required'}
password=${2:?'password is required'}
uid=${3:-1000}

adduser --gecos ${username} --disabled-password --shell /bin/bash --uid ${uid} ${username}
for i in sudo video render audio bluetooth plugdev input dialout; do
    adduser ${username} $i
done

# set password and expire it to force a change on first login
echo "${username}:${password}" | chpasswd
passwd -e "${username}"

exit 0
