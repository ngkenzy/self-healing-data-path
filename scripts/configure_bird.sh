#!/usr/bin/env bash
set -euo pipefail
# Example: install bird and apply templates (adjust if image differs)
for n in rtrA rtrB rtrC rtrD; do
  docker exec -it clab-diamond-$n bash -lc "apt-get update && apt-get install -y bird2 iproute2"
  docker cp bird/$n.conf clab-diamond-$n:/etc/bird/bird.conf
  docker exec -it clab-diamond-$n bash -lc "systemctl enable bird || true; service bird restart || bird -c /etc/bird/bird.conf -d &"
done
echo "[+] Bird configured (check logs: docker logs clab-diamond-rtrA | tail)"
