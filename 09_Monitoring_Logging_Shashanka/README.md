# 09 — Monitoring & Logging

**Est. time:** 4 weeks @ 2-5 hrs/week
**Status:** 🔲 Not started

## Why this matters for you

"It's deployed" isn't the finish line — knowing whether it's *healthy* is.
This module covers the observability stack every DevOps engineer is
expected to know.

## Topics Checklist

- [ ] The three pillars: metrics, logs, traces (high-level understanding)
- [ ] Prometheus basics: scraping metrics, PromQL fundamentals
- [ ] Grafana basics: building a dashboard from a Prometheus data source
- [ ] AWS CloudWatch: metrics, log groups/streams, alarms, dashboards
- [ ] Alerting basics: what makes a *good* alert (actionable, not noisy)
- [ ] Centralized logging concepts (ELK/EFK stack overview — doesn't need
      to be deep, just understand the pattern)

## Free Resources

- [Prometheus official "Getting Started"](https://prometheus.io/docs/prometheus/latest/getting_started/)
- [Grafana official tutorials](https://grafana.com/tutorials/)
- [AWS CloudWatch documentation](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/WhatIsCloudWatch.html)

## Hands-on Mini Project

1. Run Prometheus + Grafana locally via Docker Compose (ties back to Module 04).
2. Instrument the small app from Module 04 with a `/metrics` endpoint (most
   languages have an easy Prometheus client library).
3. Build a Grafana dashboard showing request count and latency.
4. Set up one CloudWatch alarm on your Module 06 EC2 instance and trigger it
   deliberately (e.g. stress the CPU) to see it fire.

Save dashboard JSON/screenshots + a `NOTES.md` in this folder.
