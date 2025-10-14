#!/usr/bin/env bash

set -euox pipefail

# copr repos
dnf -y copr enable yalter/niri
dnf -y copr enable solopasha/hyprland 
dnf -y copr enable scottames/ghostty
dnf -y copr enable avengemedia/danklinux
dnf -y copr enable avengemedia/dms

# use flatpak for web browser instead
dnf remove -y firefox firefox-langpacks

# desktop packages
dnf install -y \
  mate-polkit \
  brightnessctl \
  cava \
  wl-clipboard \
  fastfetch \
  fira-code-fonts \
  gammastep \
  nwg-look \
  qt6-qtmultimedia \
  qt6ct \
  xdg-desktop-portal-gnome \
  xdg-desktop-portal-gtk \
  nautilus \
  btop \
  htop \
  rsms-inter-fonts

# display manager
dnf install -y \
  sddm \
  fprintd \
  fprintd-pam

# copr (Niri, Hyprland, DMS)
dnf install -y \
  niri \
  hyprland \
  ghostty \
  matugen \
  cliphist \
  dms \
  dgop

# disable the Repos we pulled in above
dnf -y copr disable yalter/niri
dnf -y copr disable solopasha/hyprland 
dnf -y copr disable scottames/ghostty
dnf -y copr disable avengemedia/danklinux
dnf -y copr disable avengemedia/dms
