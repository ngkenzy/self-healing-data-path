#!/usr/bin/env bash
set -euo pipefail
MODE="${1:-baseline}"   # baseline | failover
C=clab-diamond-client
S=clab-diamond-sink
mkdir -p results
# start iperf server
docker exec -it $S sh -lc "pkill iperf3 || true; iperf3 -s -D"
# resolve sink IP
SIP=$(docker exec -it $C getent hosts sink | awk '{print $1}' | tr -d '\r')
echo "sink ip: $SIP"
# run multiple iperf tests, capture JSON
for i in $(seq 1 5); do
  docker exec -it $C sh -lc "iperf3 -c $SIP -t 5 -J" >> results/iperf_${MODE}.json
  sleep 1
done
# Latency samples
for i in $(seq 1 20); do
  docker exec -it $C sh -lc "ping -c1 -W1 $SIP | awk -F'/' '/rtt/ {print $5}'" | tr -d '\r' >> results/latency_${MODE}.csv
done
echo "[+] Wrote results/iperf_${MODE}.json and results/latency_${MODE}.csv"
