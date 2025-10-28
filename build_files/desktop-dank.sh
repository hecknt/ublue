#!/usr/bin/env bash

set -euox pipefail

# copr repos
dnf -y copr enable yalter/niri
dnf -y copr enable solopasha/hyprland 
dnf -y copr enable avengemedia/danklinux
dnf -y copr enable avengemedia/dms
dnf -y install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release

# use flatpak for web browser instead
dnf remove -y firefox firefox-langpacks

# desktop packages
dnf install -y \
  mate-polkit \
  brightnessctl \
  cava \
  wl-clipboard \
  fastfetch \
  gammastep \
  nwg-look \
  qt6-qtmultimedia \
  qt6ct \
  xdg-desktop-portal-gnome \
  xdg-desktop-portal-gtk \
  nautilus \
  vulkan-tools \
  v4l2loopback \
  unbound \
  ublue-polkit-rules \
  samba \
  fprintd \
  adw-gtk3-theme \
  sassc \
  libappstream-glib \
  fprintd-pam
 
# copr (Niri, Hyprland, DMS)
dnf install -y \
  niri \
  hyprland \
  matugen \
  cliphist \
  dms \
  dms-greeter \
  quickshell-git \
  dgop
systemctl enable greetd

# Systemd service to automatically create proper folders for dms-greeter
cat > /usr/lib/systemd/system/dms-greeter-folder-create.service << 'SYNC_EOF'
[Unit]
Description=Create necessary folders for dms-greeter
ConditionPathExists=/usr/bin/dms-greeter
ConditionPathExists=!/var/lib/greeter
ConditionPathExists=!/var/cache/dms-greeter
After=local-fs.target

[Service]
Type=oneshot
# Create folders
ExecStart=/usr/bin/install -dm750 /var/cache/dms-greeter
ExecStart=/usr/bin/install -dm755 /var/lib/greeter
# Set proper SELinux contexts
ExecStart=/usr/bin/semanage fcontext -a -t cache_home_t '/var/cache/dms-greeter(/.*)?'
ExecStart=/usr/bin/restorecon -R /var/cache/dms-greeter
ExecStart=/usr/bin/semanage fcontext -a -t user_home_dir_t '/var/lib/greeter(/.*)?'
ExecStart=/usr/bin/restorecon -R /var/lib/greeter
# Set proper ownership
ExecStart=/usr/bin/chown -R greeter:greeter /var/cache/dms-greeter
ExecStart=/usr/bin/chown -R greeter:greeter /var/lib/greeter
# Disable this service now that it's done
ExecStart=/usr/bin/systemctl disable dms-greeter-folder-create.service

[Install]
WantedBy=multi-user.target
SYNC_EOF

systemctl enable dms-greeter-folder-create.service

# remove zfs-fuse (why is it here????? it shouldnt be here)
rpm -e --nodeps zfs-fuse

# disable the Repos we pulled in above
dnf -y copr disable yalter/niri
dnf -y copr disable solopasha/hyprland 
dnf -y copr disable avengemedia/danklinux
dnf -y copr disable avengemedia/dms
