# 07 — Kubernetes Basics (+ AWS EKS)

**Est. time:** 6-8 weeks @ 2-5 hrs/week
**Status:** 🔲 Not started

## Why this matters for you

Kubernetes is the industry-standard way to run containers at scale. It has
a reputation for being intimidating — it isn't, once you've done Docker
(Module 04) first, which you will have by this point.

## Topics Checklist

- [ ] Core objects: Pods, Deployments, ReplicaSets, Services, Namespaces
- [ ] `kubectl` basics: get, describe, logs, exec, apply
- [ ] ConfigMaps and Secrets
- [ ] Ingress / exposing services externally
- [ ] Rolling updates and rollbacks
- [ ] Resource requests/limits, basic autoscaling (HPA)
- [ ] Helm basics (packaging/deploying charts)
- [ ] Running a small cluster locally (Minikube or kind) before touching AWS EKS
- [ ] AWS EKS overview: how it differs from a local cluster

## Free Resources

- [Kubernetes official basics tutorial](https://kubernetes.io/docs/tutorials/kubernetes-basics/)
- [Killercoda Kubernetes scenarios](https://killercoda.com/kubernetes) — free, interactive, no install
- [kind](https://kind.sigs.k8s.io/) or [Minikube](https://minikube.sigs.k8s.io/docs/start/) — free local clusters

## Hands-on Mini Project

1. Run a local cluster with `kind` or `minikube`.
2. Deploy the Dockerized app from Module 04 as a Deployment + Service.
3. Scale it to 3 replicas, then simulate a rolling update to a new image
   version, and practice a rollback.
4. (Stretch) Deploy the same app to a small AWS EKS cluster.

Save your YAML manifests + a `NOTES.md` walkthrough in this folder.
