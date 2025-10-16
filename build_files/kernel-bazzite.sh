#!/usr/bin/env bash

# CREDITS: this file is based off of this: https://github.com/renner0e/lts-kernel-example/blob/main/build_files/build.sh

set -ouex pipefail

KERNEL=$(skopeo inspect --retry-times 3 docker://ghcr.io/ublue-os/akmods:bazzite-"$(rpm -E %fedora)" | jq -r '.Labels["ostree.linux"]')

# Download Bazzite kernel
skopeo copy --retry-times 3 docker://ghcr.io/ublue-os/akmods:bazzite-"$(rpm -E %fedora)"-${KERNEL} dir:/tmp/akmods
AKMODS_TARGZ=$(jq -r '.layers[].digest' </tmp/akmods/manifest.json | cut -d : -f 2)
tar -xvzf /tmp/akmods/"$AKMODS_TARGZ" -C /tmp/
mv /tmp/rpms/* /tmp/akmods/

# Remove existing kernel WITHOUT removing anything else
dnf5 versionlock delete kernel{-core,-modules,-modules-core,-modules-extra,-tools,-tools-libs,-headers,-devel}
installed_pkgs=()
for pkg in kernel{,-core,-modules,-modules-core,-modules-extra,-tools,-tools-libs,-headers,-devel}; do
  if rpm -q "$pkg" &>/dev/null; then
    installed_pkgs+=("$pkg")
  else
    echo "Skipping $pkg (not installed)"
  fi
done
if [ ${#installed_pkgs[@]} -gt 0 ]; then
  rpm -e --nodeps "${installed_pkgs[@]}"
fi

# Install downloaded Bazzite kernel
dnf5 -y --setopt=disable_excludes=* install /tmp/kernel-rpms/*.rpm
dnf5 versionlock add kernel{,-core,-modules,-modules-core,-modules-extra,-tools,-tools-lib,-headers,-devel,-devel-matched}

# Build initramfs
KERNEL_SUFFIX=""
QUALIFIED_KERNEL="$(rpm -qa | grep -P 'kernel(|'"$KERNEL_SUFFIX"'-)(\d+\.\d+\.\d+)' | sed -E 's/kernel(|'"$KERNEL_SUFFIX"'-)//')"
/usr/bin/dracut --no-hostonly --kver "$QUALIFIED_KERNEL" --reproducible -v --add ostree -f "/lib/modules/$QUALIFIED_KERNEL/initramfs.img"
chmod 0600 "/lib/modules/$QUALIFIED_KERNEL/initramfs.img"
