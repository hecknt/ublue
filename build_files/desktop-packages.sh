#!/usr/bin/env bash

set -euox pipefail

echo "Running desktop packages scripts..."

dnf -y copr enable scottames/ghostty
dnf -y copr enable ublue-os/packages

# common packages installed to desktops
dnf5 install -y \
  kitty \
  bazaar \
  ghostty \
  picard \
  sxiv \
  libpcap-devel \
  libretls \
  ltrace \
  patch \
  pipx \
  udica \
  mpv \
  adb \
  firewall-config \
  ydotool \
  rsms-inter-fonts \
  rsms-inter-vf-fonts \
  fira-code-fonts \
  ibm-plex-fonts-all \
  jetbrains-mono-fonts-all \
  fontawesome-6-free-fonts \
  libvirt \
  libvirt-daemon-kvm \
  libvirt-ssh-proxy \
  libvirt-nss \
  qemu-img \
  qemu-kvm \
  edk2-ovmf \
  guestfs-tools \
  wev \
  ddcutil \
  breeze-cursor-theme \
  breeze-icon-theme \
  uupd

dnf -y copr disable scottames/ghostty
