#!/usr/bin/env bash

set -euox pipefail

echo "Tweaking existing desktop config..."

# remove aurora provided Inter fonts since we add the RPM
rm -rf /usr/share/fonts/inter

# replace mesa with version from terra
dnf5 -y install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release{,-extras}
dnf5 -y config-manager setopt "*terra*".priority=3 "*terra*".exclude="nerd-fonts topgrade scx-scheds steam python3-protobuf"
dnf5 -y config-manager setopt "terra-mesa".enabled=true
dnf5 -y config-manager setopt "terra-nvidia".enabled=false

dnf5 -y swap --repo=terra-mesa mesa-filesystem mesa-filesystem
