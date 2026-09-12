# DevOps Learning Roadmap — Shashanka

**Starting point:** QA & Release Engineer
**Target:** DevOps Engineer
**Pace:** ~2-5 hrs/week (realistic, sustainable pace — no burnout plan)
**Cloud focus:** AWS
**Context:** Built alongside the Tutedude internship track — Tutedude modules
(like `Linux_Basics_Shashanka`) slot into this roadmap as they're assigned;
gaps are filled with the self-study modules below.

## Why you have a head start

As a QA/Release Engineer you likely already know, at least in part:
- Git basics, build/release processes, versioning, environments (staging/prod).
- Some exposure to CI/CD tools (running pipelines, even if not authoring them).
- Basic scripting for test automation.
- A "does it actually work in production" mindset — genuinely one of the
  hardest DevOps habits to teach, and you already have it.

The plan below leans into that: less time on things you already know, more
time on the genuinely new stuff (containers, orchestration, IaC, cloud).

## How to use this doc

- Each phase has its own folder in this repo (e.g. `04_Docker_Basics_Shashanka/`)
  with a README containing the detailed checklist, free resources, and a
  hands-on mini-project.
- Check items off as you go. Don't skip the hands-on project — reading alone
  doesn't build DevOps muscle memory.
- If a Tutedude assignment covers the same ground as a phase below, just do
  the Tutedude version and check the phase off — no need to double up.

## Phase Overview (~13 months at 2-5 hrs/week — adjust as needed)

| Phase | Topic | Folder | Est. Weeks |
|---|---|---|---|
| 1 | Linux fundamentals | `Linux_Basics_Shashanka/` | Done ✅ |
| 2 | Git & GitHub (beyond basics) | `02_Git_Advanced_Shashanka/` | 3-4 |
| 3 | Bash & Python scripting for automation | `03_Bash_Python_Scripting_Shashanka/` | 4 |
| 4 | Docker & containers | `04_Docker_Basics_Shashanka/` | 5-6 |
| 5 | CI/CD pipelines as code | `05_CICD_Pipelines_Shashanka/` | 5-6 |
| 6 | AWS fundamentals + Cloud Practitioner cert | `06_AWS_Fundamentals_Shashanka/` | 6-8 |
| 7 | Kubernetes basics (+ AWS EKS) | `07_Kubernetes_Basics_Shashanka/` | 6-8 |
| 8 | Infrastructure as Code (Terraform) | `08_Terraform_IaC_Shashanka/` | 5-6 |
| 9 | Monitoring & Logging | `09_Monitoring_Logging_Shashanka/` | 4 |
| 10 | DevSecOps basics + Capstone project | `10_DevSecOps_Capstone_Shashanka/` | 4-6 |

## Milestones / Certifications (optional but recommended)

1. **AWS Certified Cloud Practitioner** — after Phase 6. Cheap, achievable,
   proves cloud fundamentals to recruiters.
2. **AWS Certified SysOps Administrator – Associate** or
   **HashiCorp Certified: Terraform Associate** — after Phase 8, whichever
   matches the roles you're targeting.
3. **Capstone project** (Phase 10) — a small app with: Dockerized service →
   CI/CD pipeline (test/build/push) → deployed to AWS (EKS or ECS) via
   Terraform → monitored with CloudWatch/Prometheus+Grafana. This single
   project demonstrates the entire pipeline end-to-end on your resume/GitHub.

## Job-readiness checklist (fill in as you progress)

- [ ] Comfortable with Linux CLI day-to-day
- [ ] Can write/review a multi-stage CI/CD pipeline from scratch
- [ ] Can containerize an existing application (Dockerfile + compose)
- [ ] Can deploy and troubleshoot a workload on Kubernetes
- [ ] Can provision cloud infra with Terraform (not just the console)
- [ ] Comfortable navigating AWS console + CLI for core services (EC2, S3,
      IAM, VPC, ECS/EKS, CloudWatch)
- [ ] Has a capstone project on GitHub showing the full pipeline
- [ ] Resume updated with DevOps-specific keywords/projects
