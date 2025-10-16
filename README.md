# Hec's Universal Blue Images

[![Build Desktop](https://github.com/hecknt/ublue/actions/workflows/build-desktop.yml/badge.svg)](https://github.com/hecknt/ublue/actions/workflows/build-desktop.yml)

These are my personal Universal Blue image builds, customized with my own personal additions to make my life easier. Everything is built under one single image `ublue` with different tags for different environments.

## Desktop Images

- `ublue:aurora` - an Aurora stable image with packages added for my benefit. A great option for KDE users.
- `ublue:danklinux` - an image built off of `ublue/base-main` with both Niri and Hyprland installed, along with [DankMaterialShell](https://github.com/AvengeMedia/DankMaterialShell/) and various other utilities to make the desktop more complete. A great option for Tiling Window Manager users.

### Sub-Images: bazzite-kernel
#### NOTE: `bazzite-kernel` IMAGES ARE COMPLETELY BROKEN RIGHT NOW. <ins>DO NOT USE.</ins>

Images built with `bazzite-kernel` in the name have the kernel used in [Bazzite](https://bazzite.gg) installed instead of the main kernel. Examples include:
- `ublue:aurora-bazzite-kernel`
- `ublue:danklinux-bazzite-kernel-nvidia`

### Sub-Images: nvidia
Images built with `nvidia` in the name have the NVIDIA drivers installed in the image. Examples include:
- `ublue:aurora-nvidia`
- `danklinux-bazzite-kernel-nvidia`

## Installation

Install a base build of any Fedora Atomic or Universal Blue image (eg. Sericea, Kinoite, Aurora) and then switch to an image like so:

```
sudo bootc switch --enforce-container-sigpolicy ghcr.io/hecknt/ublue:TAG
```

## Verification

These images are signed with [cosign](https://docs.sigstore.dev/cosign/overview/). You can verify the signature by downloading the `cosign.pub` file and running:

```
cosign verify --key cosign.pub ghcr.io/hecknt/ublue:TAG
```

