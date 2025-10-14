#!/usr/bin/env bash

set -euox pipefail

# common packages installed to desktops and servers
dnf5 install -y \
  bc \
  ccache \
  git \
  gh \
  erofs-utils \
  hdparm \
  iotop \
  ipcalc \
  iperf3 \
  just \
  lm_sensors \
  lshw \
  netcat \
  nmap \
  picocom \
  socat \
  unrar \
  neovim \
  btop \
  htop \
  lzip \
  p7zip \
  p7zip-plugins \
  strace \
  powertop \
  nu \
  zsh
