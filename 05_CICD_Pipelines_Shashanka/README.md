# 05 — CI/CD Pipelines as Code

**Est. time:** 5-6 weeks @ 2-5 hrs/week
**Status:** 🔲 Not started

## Why this matters for you

As a release engineer you've likely *run* pipelines before — this module is
about *authoring* them: writing the pipeline-as-code yourself, from test
through build through deploy. This tends to be the fastest "aha" module
given your background.

## Topics Checklist

- [ ] CI/CD concepts: stages, artifacts, caching, secrets, environments
- [ ] GitHub Actions: workflow YAML syntax, jobs, steps, triggers
- [ ] Building a pipeline: lint → test → build Docker image → push to registry
- [ ] Managing secrets (GitHub Secrets / environment protection rules)
- [ ] Matrix builds, caching dependencies for speed
- [ ] Basic deployment step (e.g. deploy to a free host, or simulate deploy)
- [ ] (Optional) Same concepts in Jenkins or GitLab CI, if your target jobs
      use those instead

## Free Resources

- [GitHub Actions documentation](https://docs.github.com/en/actions) + "Quickstart"
- [GitHub Skills: "Continuous Integration"](https://skills.github.com/)
- [Jenkins official tutorials](https://www.jenkins.io/doc/tutorials/) (if targeting Jenkins-heavy job market)

## Hands-on Mini Project

Take the Dockerized app from Module 04 and build a full pipeline:
1. On every push: lint the code, run any tests.
2. On push to `main`: build the Docker image and push it to Docker Hub/GHCR.
3. Add a manual-approval or environment-protection step before a (simulated)
   "deploy" job.
4. Store the workflow file in `.github/workflows/` in that project, and link
   to it (or copy it) into this folder with a `NOTES.md` explaining each stage.
