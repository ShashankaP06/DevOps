# 04 — Docker & Containers

**Est. time:** 5-6 weeks @ 2-5 hrs/week
**Status:** 🟨 In progress

## Why this matters for you

Containers are the foundation almost everything else (CI/CD, Kubernetes,
most modern deployments) is built on. This is one of the highest-value
modules in the whole roadmap.

## Topics Checklist

- [x] Images vs containers, the Docker daemon/client model
- [ ] Writing a `Dockerfile` (layers, caching complete; multi-stage pending)
- [x] Running/stopping/inspecting containers, `docker logs`, `docker exec`
- [x] Volumes and bind mounts (persisting data)
- [x] Docker networking basics (bridge networks, exposing ports)
- [x] Docker Compose for multi-container apps
- [ ] Image tagging, pushing to a registry (Docker Hub or AWS ECR)
- [ ] Basic image security hygiene (small base images, not running as root,
      scanning with `docker scout` or `trivy`)

## Free Resources

- [Docker Get Started guide](https://docs.docker.com/get-started/) (official)
- [Play with Docker](https://labs.play-with-docker.com/) — free browser sandbox, no install needed
- [Docker Curriculum](https://docker-curriculum.com/) — well-loved free tutorial

## Hands-on Mini Project

Containerize a small existing app (can even be a Tutedude script from an
earlier module, or a tiny Flask/Node "hello world"):
1. Write a `Dockerfile` for it.
2. Build and run it locally, confirm it works.
3. Write a `docker-compose.yml` that runs the app alongside a second
   service (e.g. a Redis or Postgres container) and connect them.
4. Push the image to Docker Hub (or AWS ECR once you reach Phase 6).

Put the app + Dockerfile + compose file + a `NOTES.md` explaining each step
in this folder.

## Capstone progress

The DevOps Release Management Platform now runs as four healthy containers:

- Nginx public gateway
- Non-root FastAPI application
- PostgreSQL persistent database
- Redis persistent cache

See [`NOTES.md`](./NOTES.md) and [`evidence/`](./evidence) for architecture,
commands, troubleshooting, industry usage, and genuine execution results.
