Investigate the sample incident using an agent team.

Create three independent teammates:
1. Kubernetes investigator owns `evidence/kubernetes-events.log`.
2. Infrastructure investigator owns `evidence/terraform-change.txt`.
3. Observability investigator owns `evidence/metrics-and-logs.txt`.

Create a shared task list. Each teammate must return:
- hypothesis;
- timestamped evidence;
- confidence;
- one question for another teammate;
- a read-only next check.

Ask teammates to message one another when evidence crosses layers. Keep all work read-only. Only the lead may synthesize `incident-summary.md`. The synthesis must separate symptom, contributing factor, probable root cause, missing evidence, and safe next checks. Do not contact a cluster or cloud account.

