# 10 — DevSecOps Basics + Capstone Project

**Est. time:** 4-6 weeks @ 2-5 hrs/week
**Status:** 🔲 Not started

## Why this matters for you

Security can't be bolted on at the end — DevSecOps means baking basic
security practices into the pipeline itself. This final module also ties
every previous module together into one portfolio-ready project.

## DevSecOps Topics Checklist

- [ ] OWASP Top 10 — high-level familiarity, not deep pentesting
- [ ] Secrets management (never hardcoding credentials; using
      GitHub Secrets/AWS Secrets Manager/Vault basics)
- [ ] Dependency/image scanning in CI (e.g. `trivy`, `npm audit`, `pip-audit`)
- [ ] Least-privilege IAM (revisit Module 06 with a security lens)
- [ ] Basic security groups / network segmentation review

## Free Resources

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [Trivy scanner](https://aquasecurity.github.io/trivy/) — free, easy to add to any CI pipeline
- [AWS Secrets Manager docs](https://docs.aws.amazon.com/secretsmanager/)

## Capstone Project

Combine everything from Modules 02-09 into one end-to-end project:

1. A small app (any language) in its own Git repo, with a clean branching
   workflow (Module 02).
2. Automation scripts for setup/health-checks (Module 03).
3. Dockerized (Module 04).
4. Full CI/CD pipeline: lint → test → security scan → build → push image →
   deploy (Modules 05 & 10).
5. Deployed to AWS — either ECS or EKS (Modules 06 & 07).
6. Infrastructure defined in Terraform, not clicked in the console (Module 08).
7. Monitored with a dashboard + at least one working alert (Module 09).

Write this up properly with architecture diagram, screenshots, and a clear
README — this project is what you show recruiters/interviewers.
