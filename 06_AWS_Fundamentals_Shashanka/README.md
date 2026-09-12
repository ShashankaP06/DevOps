# 06 — AWS Fundamentals (+ Cloud Practitioner cert)

**Est. time:** 6-8 weeks @ 2-5 hrs/week
**Status:** 🔲 Not started

## Why this matters for you

Cloud skills are the most in-demand DevOps skill by far. AWS specifically
has the largest job market. This module builds the fundamentals and
prepares you for the (optional but valuable) AWS Certified Cloud
Practitioner exam.

## Topics Checklist

- [ ] IAM: users, groups, roles, policies, least-privilege principle
- [ ] EC2: launching instances, security groups, key pairs, SSH access
- [ ] S3: buckets, permissions, static hosting, lifecycle rules
- [ ] VPC basics: subnets, route tables, internet gateways, security groups
      vs NACLs
- [ ] ECS or EKS overview (container hosting on AWS) — deep dive comes in
      Module 07
- [ ] CloudWatch basics: metrics, logs, alarms
- [ ] AWS CLI: configuring credentials, running commands, scripting with it
- [ ] Billing/cost basics: free tier limits, budgets/alerts (important —
      avoid surprise bills!)

## Free Resources

- [AWS Skill Builder](https://skillbuilder.aws/) — official, free courses including Cloud Practitioner Essentials
- [AWS Free Tier](https://aws.amazon.com/free/) — set a billing alarm on day one
- [AWS Certified Cloud Practitioner exam guide](https://aws.amazon.com/certification/certified-cloud-practitioner/)

## Hands-on Mini Project

1. Launch an EC2 instance, SSH into it, and deploy a simple web app manually.
2. Create an S3 bucket and host a static site on it.
3. Set up a CloudWatch alarm on that EC2 instance (e.g. CPU usage).
4. Write an AWS CLI script that automates steps 1-2 instead of using the console.

Document commands, screenshots, and lessons learned in a `NOTES.md` here.
**Set a billing alarm before doing anything else in this module.**
