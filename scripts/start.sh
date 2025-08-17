#!/usr/bin/env bash
set -euo pipefail
clab deploy -t clab/diamond.clab.yml
echo "[+] Deployed. Use configure_bird.sh or configure_frr.sh next."
