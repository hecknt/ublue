#!/usr/bin/env bash

# CREDITS: this file is based off of this: https://github.com/renner0e/lts-kernel-example/blob/main/build_files/build.sh

set -ouex pipefail

mkdir /tmp/bazzite-kernel-build
KERNEL=$(skopeo inspect --retry-times 3 docker://ghcr.io/ublue-os/akmods:bazzite-"$(rpm -E %fedora)" | jq -r '.Labels["ostree.linux"]')

# Download Bazzite kernel
skopeo copy --retry-times 3 docker://ghcr.io/ublue-os/akmods:bazzite-"$(rpm -E %fedora)"-${KERNEL} dir:/tmp/bazzite-kernel-build/akmods
AKMODS_TARGZ=$(jq -r '.layers[].digest' </tmp/bazzite-kernel-build/akmods/manifest.json | cut -d : -f 2)
tar -xvzf /tmp/bazzite-kernel-build/akmods/"$AKMODS_TARGZ" -C /tmp/bazzite-kernel-build
mv /tmp/bazzite-kernel-build/rpms/* /tmp/bazzite-kernel-build/akmods/

# Remove existing kernel WITHOUT removing anything else
dnf5 versionlock delete kernel{-core,-modules,-modules-core,-modules-extra,-tools,-tools-libs,-headers,-devel}
dnf5 -y remove --no-autoremove kernel-modules kernel-modules-core kernel-modules-extra

# Install downloaded Bazzite kernel
dnf5 -y --setopt=disable_excludes=* install /tmp/bazzite-kernel-build/kernel-rpms/kernel{,-core,-modules,-modules-core,-modules-extra,-devel,-devel-matched}-${KERNEL}.rpm
dnf5 versionlock add kernel{,-core,-modules,-modules-core,-modules-extra,-tools,-tools-libs,-headers,-devel,-devel-matched}
# reinstall virtualbox-guest-additions that got caught in the crossfire 
dnf5 -y install virtualbox-guest-additions

# Build initramfs
KERNEL_SUFFIX=""
export DRACUT_NO_XATTR=1 # i think this fixes something? i have no idea
QUALIFIED_KERNEL="$(rpm -qa | grep -P 'kernel(|'"$KERNEL_SUFFIX"'-)(\d+\.\d+\.\d+)' | sed -E 's/kernel(|'"$KERNEL_SUFFIX"'-)//')"
/usr/bin/dracut --no-hostonly --kver "$QUALIFIED_KERNEL" --reproducible -v --add ostree -f "/lib/modules/$QUALIFIED_KERNEL/initramfs.img"
chmod 0600 "/lib/modules/$QUALIFIED_KERNEL/initramfs.img"
