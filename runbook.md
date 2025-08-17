# Runbook

- Check BGP sessions: `vtysh -c 'show ip bgp summary'` or `birdc show protocols`
- Restart daemons: `service frr restart` or `service bird restart`
- Rollback: re-apply configs from /etc
- Logs: `docker logs clab-diamond-<node>`
