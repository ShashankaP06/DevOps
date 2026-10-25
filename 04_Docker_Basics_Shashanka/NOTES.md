# Module 04 Notes — Docker Foundation

## Current architecture

```text
Host :8080
    |
    v
Nginx gateway
    |
    v
FastAPI release API
    |             |
    v             v
PostgreSQL      Redis
```

Only Nginx publishes a host port. The API, database, and cache communicate on
the private Compose network using service names as DNS hostnames.

## Application features

- Register and list services.
- Record and list releases.
- Store durable records in PostgreSQL.
- Cache release statistics in Redis for 60 seconds.
- Report PostgreSQL and Redis connectivity through `/health`.
- Route public traffic through Nginx.

## Commands learned

```bash
docker build -t release-api:0.1.1 .
docker run --rm release-api:0.1.1 pytest -v
docker run -d --name release-api -p 8000:8000 release-api:0.1.1
docker ps
docker logs release-api
docker exec release-api id
docker stop release-api
docker rm release-api

docker compose config --quiet
docker compose up -d --build
docker compose ps
docker compose logs api
docker compose exec cache redis-cli ping
docker compose down

docker build --target test -t release-api:test .
docker run --rm release-api:test
docker build --target production -t release-api:0.3.0 .
docker scout quickview release-api:0.3.0
docker scout cves --only-severity critical,high release-api:0.3.0
docker sbom release-api:0.3.0 --format spdx-json
docker tag release-api:0.3.0 ghcr.io/shashankap06/release-api:0.3.0
```

## Concepts demonstrated

- An image is an immutable template; a container is a running instance.
- Dockerfile instructions form cached layers. Copying dependencies before
  frequently changing source code improves rebuild speed.
- The API runs as UID `10001` instead of root.
- Compose creates service discovery and an isolated bridge network.
- Named volumes preserve database/cache data when containers are recreated.
- `depends_on` with health conditions controls startup order.
- Running is not the same as ready; health checks test application behaviour.
- Nginx provides one public entry point while internal services stay private.
- Multi-stage builds isolate builder, test, runtime, and production concerns.
- Version tags identify immutable releases while `latest` is a moving reference.
- An SBOM inventories packages for vulnerability and license investigations.

## Troubleshooting evidence

The API was initially reachable before it was ready, producing a connection
reset. An API health check made readiness visible. The first Nginx health probe
used `localhost`, which resolved to IPv6 while Nginx listened on IPv4. Changing
the probe to `127.0.0.1` fixed it. This demonstrates evidence-driven diagnosis
using `docker inspect` and service logs.

## Security choices

- Minimal `python:3.12-slim` and Alpine service images.
- Non-root API process.
- `.dockerignore` reduces context and avoids unnecessary files.
- `.env` is ignored by Git.
- PostgreSQL, Redis, and the API have no host-published ports.
- The production image excludes pytest and test source files.
- The local password is only for development; production secrets belong in a
  secret manager.

## Vulnerability decision

Docker Scout reported zero critical vulnerabilities and one high-severity
finding in Debian's `zlib` package (`CVE-2026-85091`). No fixed package or
recommended replacement base tag was available at scan time. The finding is
documented as an upstream risk. The image should be rebuilt and rescanned when
an updated base image becomes available.

## Registry handoff

The production image is tagged as
`ghcr.io/shashankap06/release-api:0.3.0` and `latest`. Module 05 will securely
publish these tags from GitHub Actions using its short-lived repository token,
matching the same workflow used with AWS ECR and CI service credentials.
