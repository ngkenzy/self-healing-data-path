#!/usr/bin/env bash
set -euo pipefail
# naive test: measure downtime window during link flap by ping
C=clab-diamond-client
SIP=$(docker exec -it $C getent hosts sink | awk '{print $1}' | tr -d '\r')
t0=$(date +%s%3N)
docker exec -it clab-diamond-rtrB ip link set eth1 down
lost=0
for i in $(seq 1 50); do
  if ! docker exec -it $C ping -c1 -W1 $SIP >/dev/null 2>&1; then lost=$((lost+1)); fi
done
docker exec -it clab-diamond-rtrB ip link set eth1 up
t1=$(date +%s%3N)
echo "$((t1-t0)) ms total window; lost=$lost" | tee results/convergence.txt
