#!/usr/bin/env bash
set -euo pipefail
# If you change router images to frrouting/frr, push configs:
for n in rtrA rtrB rtrC rtrD; do
  docker cp frr/$n.conf clab-diamond-$n:/etc/frr/frr.conf
  docker exec -it clab-diamond-$n bash -lc "service frr restart || /usr/lib/frr/frrinit.sh start || true"
done
echo "[+] FRR configured"
