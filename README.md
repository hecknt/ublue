# Hec's Universal Blue Images

## This project is archived, and will not receive any further updates!
> [!IMPORTANT]
>
> If you are using any `danklinux` images, you can safely migrate over to [danklinux-bluebuild](https://github.com/hecknt/danklinux-bluebuild), where equivalent images are still being built and updated.
>
> If you are using any `aurora` images, you will have to migrate over to [Base Aurora](https://getaurora.dev) or build your own Aurora image using either [blue-build](https://github.com/blue-build/template) or the [ublue-os image template](https://github.com/ublue-os/image-template).

[![Build Desktop](https://github.com/hecknt/ublue/actions/workflows/build-desktop.yml/badge.svg)](https://github.com/hecknt/ublue/actions/workflows/build-desktop.yml)

These are my personal Universal Blue image builds, customized with my own personal additions to make my life easier. Everything is built under one single image `ublue` with different tags for different environments.

## Desktop Images

- `ublue:aurora` - an Aurora:stable image with packages added for my benefit. A great option for KDE users. 
- `ublue:danklinux` - an image built off of `ublue/base-main` with both Niri and Hyprland installed, along with [DankMaterialShell](https://github.com/AvengeMedia/DankMaterialShell/) and various other utilities to make the desktop more complete. A great option for Tiling Window Manager users.

### <ins>Sub-Images: kernel-cachyos</ins>

Images built with `kernel-cachyos` in the name have the kernel used in [CachyOS](https://cachyos.org) installed instead of the main kernel. Currently, the only image built with this is:
- `ublue:danklinux-kernel-cachyos`

### <ins>Sub-Images: nvidia</ins>
Images built with `nvidia` in the name have the NVIDIA drivers installed in the image. Examples include:
- `ublue:aurora-nvidia`
- `ublue:danklinux-nvidia`

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

