#!/usr/bin/env bash

set -euox pipefail

echo "Running desktop packages scripts..."

# ublue staging repo needed for ghostty, etc
dnf5 -y copr enable ublue-os/staging

# common packages installed to desktops
dnf5 install -y \
  ccache \
  git \
  gh \
  kitty \
  picard \
  sxiv \
  libpcap-devel \
  libretls \
  ltrace \
  patch \
  pipx \
  strace \
  udica \
  ydotool \
  btop \
  htop \
  rsms-inter-fonts \
  ibm-plex-fonts-all \
  jetbrains-mono-fonts-all \
  libvirt \
  libvirt-daemon-kvm \
  libvirt-ssh-proxy \
  libvirt-nss \
  qemu-img \
  qemu-kvm \
  edk2-ovmf \
  guestfs-tools

dnf5 -y copr disable ublue-os/staging
