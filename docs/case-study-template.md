# Case Study — Self-Healing Data Path

## Problem
Provide resilient data transport; minimize failover impact on throughput/latency.

## Context & Constraints
Single-host lab; limited CPU; standard Linux tools.

## Architecture
- Containerlab 4-router diamond
- BGP peering with BFD
- iperf3 + fping metrics

## Experiments
- Baseline vs. single-link failure
- `tc netem` latency/loss profiles

## Results (fill in)
- Reconvergence: ___ ms
- Throughput: ___ % of baseline
- Latency change: ___ ms

## Lessons
- Trade-offs (BFD intervals vs CPU)
- Route policy knobs
