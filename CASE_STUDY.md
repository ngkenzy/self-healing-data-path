# Case Study for Self-Healing Data Path

## Problem
In WAN environments, link failures can cause service disruption if routing protocols take too long to reconverge. Traditional BGP convergence may take seconds — unacceptable for low-latency workloads. The challenge was to engineer a resilient data path that self-heals in under 300 ms.

## Scenario
- **Topology:** Diamond (rtrA–rtrB–rtrD and rtrA–rtrC–rtrD)  
- **Protocols:** BGP for reachability, BFD for fast failure detection  
- **Test:** Injected link failure on `rtrB:eth1` while running `iperf3` baseline traffic  
- **Tools:** containerlab + FRR, bash scripts for failure injection & measurement  

## Results
- **BGP Sessions:** Established across rtrA–rtrB, rtrA–rtrC, rtrB–rtrD, rtrC–rtrD  
- **Reconvergence:** 242 ms (BFD-triggered)  
- **Throughput:** 920 Mbps sustained (96.8% of baseline)  
- **Artifacts:** `results/failover.txt` includes logs and measurements  

## Lessons
- **Automation patterns:** Containerlab + configure scripts enabled quick repeatable experiments  
- **Failure modes discovered:**  
  - Without BFD, failover time exceeded 3 seconds  
  - With BFD tuned to 50ms hello, 3x multiplier → reconvergence <300 ms  
- **Key takeaway:** Self-healing data paths can be validated virtually, giving confidence in failover performance before hardware deployment.  
