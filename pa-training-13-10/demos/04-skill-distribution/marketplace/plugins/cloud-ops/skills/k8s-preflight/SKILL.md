---
name: k8s-preflight
description: Prepares read-only evidence for a Kubernetes manifest change before deployment. Use when the user asks for a preflight review, rollout risk summary, or verification plan. Never deploy or mutate a cluster.
disable-model-invocation: true
allowed-tools: Read Grep Glob
---

# Kubernetes preflight

1. Read the changed manifests and the repository deployment rules.
2. Identify workload, namespace, image, probes, resources, and rollout strategy.
3. Report missing evidence and risky defaults.
4. Produce read-only validation commands.
5. End with these headings: `Change`, `Risk`, `Missing evidence`, `Preflight commands`, `Human decision`.

Never run `kubectl apply`, `helm upgrade`, or a command that changes cluster state.

