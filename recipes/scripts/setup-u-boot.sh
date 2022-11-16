#!/usr/bin/env bash
# This script is intended to be run from the rootfs of the image.
# It will generate /etc/default/u-boot, and then run u-boot-update.
set -e

devicetree=${1:?'devicetree is required'}
arch=${2:-'arm64'}

# rootfs UUID maps from https://uapi-group.org/specifications/specs/discoverable_partitions_specification
case "${arch}" in
    arm64|aarch64)
        rootfs_uuid='b921b045-1df0-41c3-af44-4c6f280d3fae'
    ;;
    arm|armhf|aarch32)
        rootfs_uuid='69dad710-2ce4-4e3c-b16c-21a1d49abed3'
    ;;
    riscv64|rv64)
        rootfs_uuid='72ec70a6-cf74-40e6-bd49-4bda08e8f224'
    ;;
    riscv32|rv32)
        rootfs_uuid='60d5a7fe-8e7d-435c-b714-3dd8162144e1'
    ;;
    x64|x86_64|amd64)
        rootfs_uuid='4f68bce3-e8cd-4db1-96e7-fbcaf984b709'
    ;;
    loongarch64)
        rootfs_uuid='77055800-792c-4f94-b39a-98c91b762bb6'
    ;;
esac

# Generate /etc/default/u-boot
cat <<EOF > /etc/default/u-boot
## /etc/default/u-boot - configuration file for u-boot-update(8)

U_BOOT_UPDATE="true"

U_BOOT_ALTERNATIVES="default recovery"
U_BOOT_DEFAULT="l0"
U_BOOT_ENTRIES="all"
U_BOOT_MENU_LABEL="debian't GNU/Linux"
U_BOOT_PARAMETERS="earlycon=uart8250,mmio32,0xfe660000 console=ttyS2,1500000n8 rw rootwait audit=0 nosplash loglevel=8"
U_BOOT_ROOT="root=UUID=${rootfs_uuid}"
U_BOOT_TIMEOUT="30"
U_BOOT_FDT="${devicetree}"
U_BOOT_FDT_DIR="/usr/lib/linux-image-"
#U_BOOT_FDT_OVERLAYS=""
#U_BOOT_FDT_OVERLAYS_DIR="/boot/dtbo/"
EOF

# Run u-boot-update
/usr/sbin/u-boot-update

# done
exit 0
