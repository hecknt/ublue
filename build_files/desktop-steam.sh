#!/usr/bin/bash

set -eoux pipefail

# OBS-VKcapture
dnf5 -y copr enable bazzite-org/obs-vkcapture

# Bazzite Repos
dnf5 -y copr enable bazzite-org/bazzite
dnf5 -y copr enable bazzite-org/bazzite-multilib

find /etc/yum.repos.d/

sed -i "0,/enabled=0/{s/enabled=0/enabled=1/}" /etc/yum.repos.d/negativo17-fedora-multimedia.repo

/ctx/steam.sh

sed -i "s@enabled=1@enabled=0@" /etc/yum.repos.d/negativo17-fedora-multimedia.repo

# disable the Repos we pulled in above
dnf5 -y copr disable bazzite-org/obs-vkcapture
dnf5 -y copr disable bazzite-org/bazzite
dnf5 -y copr disable bazzite-org/bazzite-multilib
