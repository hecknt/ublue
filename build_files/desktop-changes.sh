#!/usr/bin/env bash

set -euox pipefail

echo "Tweaking existing desktop config..."

# remove aurora provided Inter fonts since we add the RPM
rm -rf /usr/share/fonts/inter
