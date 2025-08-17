#!/usr/bin/env bash
set -euo pipefail
NODE="${1:-rtrB}"
IFACE="${2:-eth1}"
DUR="${3:-5}"
echo "[*] Bringing $NODE:$IFACE down for $DUR s"
docker exec -it clab-diamond-$NODE ip link set $IFACE down
sleep "$DUR"
docker exec -it clab-diamond-$NODE ip link set $IFACE up
echo "[+] Restored $NODE:$IFACE"
