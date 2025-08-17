![CI](https://github.com/ngkenzy/<repo>/actions/workflows/ci.yml/badge.svg)

# Self-Healing Data Path (BGP + BFD + Failover) — Portfolio Project

**Story:** Engineer a resilient data path. When a link fails, traffic reconverges in <300 ms via BFD; throughput and latency stay within SLOs. Includes tests, ADRs, and a short demo.

> Works on a single Linux host using [containerlab](https://containerlab.dev/). Routers run a minimal Linux image; you can use Bird or FRRouting (FRR). Client/Sink run a net-tools image with iperf3.

## Topology
```
client -- rtrA == rtrB -- sink
           \       //
            rtrC == rtrD
```
Two disjoint paths (A-B-D and A-C-D).

## Quickstart
```bash
# 0) prerequisites
# - Docker, containerlab, bash, jq
# - Recommended: Linux host or UTM Linux VM with nested virtualization enabled

# 1) deploy
clab deploy -t clab/diamond.clab.yml

# 2) configure routers (choose one stack)
# Bird:
scripts/configure_bird.sh
# or FRR:
# scripts/configure_frr.sh

# 3) baseline metrics
scripts/measure.sh baseline

# 4) inject failures and measure reconvergence
scripts/inject_failure.sh rtrB eth1 5
scripts/measure.sh failover

# 5) destroy
clab destroy -t clab/diamond.clab.yml -a
```

## Results & Success Criteria
- BGP sessions Established across A-B, A-C, B-D, C-D
- BFD triggers reconvergence **< 300 ms** (target)
- Throughput ≥ 90% of baseline during single-link failure
- Latency within agreed SLO
Artifacts saved to `results/` as CSV/JSON, plus charts (you can plot externally).

## Repo Map
- `clab/diamond.clab.yml` — topology
- `bird/*.conf` — Bird configs (if you choose Bird)
- `frr/*.conf` — FRR configs (if you choose FRR)
- `scripts/*.sh` — deploy/config/test/failure-injection/metrics collection
- `docs/diagram.svg` — simple diagram (edit in draw.io/inkscape)
- `docs/adr/*.md` — Architecture Decision Records
- `runbook.md` — ops notes, rollback
- `results/` — exported measurements

> NOTE: Images here are sane defaults. If you get package errors inside nodes, switch images in the clab file (e.g., use `frrouting/frr` for routers) and re-run configure scripts.

## Resume bullet (example)
- Engineered BGP+BFD failover in a virtual WAN: reconvergence **< 300 ms** under single-link failure; maintained ≥90% throughput; authored ADRs, tests, and runbook.
