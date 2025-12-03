#!/bin/bash
set -euo pipefail
mkdir -p /usr/lib/systemd/user/default.target.wants
ln -sf ../dms-skel.service /usr/lib/systemd/user/default.target.wants/