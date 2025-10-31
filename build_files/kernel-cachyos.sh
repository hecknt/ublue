#!/usr/bin/env bash

set -ouex pipefail

dnf5 -y copr enable bieszczaders/kernel-cachyos
dnf5 -y copr enable bieszczaders/kernel-cachyos-addons

# Remove existing kernel
dnf5 versionlock delete kernel{-core,-modules,-modules-core,-modules-extra,-tools,-tools-libs,-headers,-devel}
dnf5 -y remove --no-autoremove --setopt protect_running_kernel=false kernel-modules kernel-modules-core kernel-modules-extra

# Install CachyOS kernel & addons
dnf5 -y install kernel-cachyos{,-core,-modules,-devel,-devel-matched} || true

# Make sure that the kernel packages are listed as installed. If this command fails, then the script will exit with an error. 
# The post-install script for kernel-cachyos-core errors out when trying to run dracut, requiring || true to let the script continue anyways.
# We already run dracut later in the script, so this error can safely be ignored. If the package does actually fail to install, however, then the entire build should fail.
dnf5 list --installed kernel-cachyos kernel-cachyos-core kernel-cachyos-devel kernel-cachyos-devel-matched kernel-cachyos-modules

dnf5 versionlock add kernel-cachyos{,-core,-modules,-devel,-devel-matched}
dnf5 -y swap zram-generator-defaults cachyos-settings
dnf5 -y install scx-scheds
## reinstall virtualbox-guest-additions that got caught in the crossfire 
dnf5 -y install virtualbox-guest-additions

# install nvidia-open module for nvidia images (NOTE: I DO NOT TEST NVIDIA IMAGES)
case "${IMAGE}" in
  *"-nvidia")
    dnf5 -y install \
      kernel-cachyos-nvidia-open \
      nvidia-driver \
      nvidia-driver-cuda \
      nvidia-kmod-common \
      nvidia-settings
  ;;
esac

# Build initramfs
KERNEL_SUFFIX="-cachyos"
export DRACUT_NO_XATTR=1 # i think this fixes something? i have no idea
QUALIFIED_KERNEL="$(rpm -qa | grep -P 'kernel(|'"$KERNEL_SUFFIX"'-)(\d+\.\d+\.\d+)' | sed -E 's/kernel(|'"$KERNEL_SUFFIX"'-)//')"
/usr/bin/dracut --no-hostonly --kver "$QUALIFIED_KERNEL" --reproducible -v --add ostree -f "/lib/modules/$QUALIFIED_KERNEL/initramfs.img"
chmod 0600 "/lib/modules/$QUALIFIED_KERNEL/initramfs.img"
