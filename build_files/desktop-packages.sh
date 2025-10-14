#!/usr/bin/env bash

set -euox pipefail

echo "Running desktop packages scripts..."

dnf -y copr enable scottames/ghostty

# common packages installed to desktops
dnf5 install -y \
  kitty \
  ghostty \
  picard \
  sxiv \
  libpcap-devel \
  libretls \
  ltrace \
  patch \
  pipx \
  udica \
  ydotool \
  rsms-inter-fonts \
  fira-code-fonts \
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

dnf -y copr disable scottames/ghostty
