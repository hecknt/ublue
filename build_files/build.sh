#!/bin/bash

set -ouex pipefail

# desktop stuff (courtesy of bOS)
case "${IMAGE}" in
"aurora"*|"bluefin"*|"danklinux"*)
  /ctx/desktop-changes.sh
  /ctx/desktop-packages.sh
  /ctx/desktop-steam.sh
  ;;
esac

case "${IMAGE}" in
"danklinux"*)
  /ctx/desktop-dank.sh
  ;;
esac

# general stuff (also done on server)
/ctx/general-packages.sh
/ctx/signing.sh
