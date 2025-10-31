#!/usr/bin/bash

set -eoux pipefail

sed -i "0,/enabled=0/{s/enabled=0/enabled=1/}" /etc/yum.repos.d/negativo17-fedora-multimedia.repo

STEAM_PACKAGES=(
    clinfo
    gamescope.x86_64
    gamescope-libs.i686
    gamescope-shaders
    gobject-introspection
    libFAudio.i686
    libFAudio.x86_64
    libobs_glcapture.i686
    libobs_vkcapture.i686
    libobs_glcapture.x86_64
    libobs_vkcapture.x86_64
    lutris
    mangohud.i686
    mangohud.x86_64
    mesa-va-drivers.i686
    mesa-vulkan-drivers.i686
    steam
    umu-launcher
    vkBasalt.i686
    vkBasalt.x86_64
    winetricks
    wine-core.i686
    wine-core.x86_64
    wine-pulseaudio.i686
    wine-pulseaudio.x86_64
)

dnf5 install -y "${STEAM_PACKAGES[@]}"

ln -sf wine32 /usr/bin/wine
ln -sf wine32-preloader /usr/bin/wine-preloader
ln -sf wineserver64 /usr/bin/wineserver
sed -i 's@\[Desktop Entry\]@\[Desktop Entry\]\nNoDisplay=true@g' /usr/share/applications/winetricks.desktop

sed -i "s@enabled=1@enabled=0@" /etc/yum.repos.d/negativo17-fedora-multimedia.repo

# this allows mangohud to read CPU power wattage
tee /usr/lib/systemd/system/sysfs-read-powercap-intel.service << EOF
[Unit]
Description=Set readable intel cpu power
After=systemd-udevd.service
After=tuned.service
ConditionPathExists=/sys/class/powercap/intel-rapl:0/energy_uj

[Service]
Type=oneshot
ExecStart=chmod a+r /sys/class/powercap/intel-rapl:0/energy_uj
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF
systemctl enable sysfs-read-powercap-intel.service
