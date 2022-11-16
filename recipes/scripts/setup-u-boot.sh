#!/usr/bin/env bash
# This script is intended to be run from the rootfs of the image.
# It will generate /etc/default/u-boot, and then run u-boot-update.
set -e

boardname=${1:?'board name is required'}

# Generate /etc/default/u-boot
cat <<EOF > /etc/default/u-boot
## /etc/default/u-boot - configuration file for u-boot-update(8)

U_BOOT_UPDATE="true"

U_BOOT_ALTERNATIVES="default recovery"
U_BOOT_DEFAULT="l0"
U_BOOT_ENTRIES="all"
U_BOOT_MENU_LABEL="debian't GNU/Linux"
U_BOOT_PARAMETERS="earlycon=uart8250,mmio32,0xfe660000 console=ttyS2,1500000n8 rw rootwait audit=0 nosplash loglevel=8"
U_BOOT_ROOT="root=LABEL=ROOTFS"
U_BOOT_TIMEOUT="30"
U_BOOT_FDT="rockchip/${boardname}.dtb"
U_BOOT_FDT_DIR="/usr/lib/linux-image-"
#U_BOOT_FDT_OVERLAYS=""
#U_BOOT_FDT_OVERLAYS_DIR="/boot/dtbo/"
EOF

# Run u-boot-update
/usr/sbin/u-boot-update

# done
exit 0
