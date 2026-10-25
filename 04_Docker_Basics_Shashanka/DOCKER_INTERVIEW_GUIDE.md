# Docker DevOps Interview Guide

## Core concepts

**What is the difference between an image and a container?**
An image is an immutable, layered application template. A container is an
isolated process created from an image, with a writable container layer and
runtime configuration.

**How does the Docker client communicate with the daemon?**
The CLI sends API requests to the Docker daemon through a Unix socket or
network endpoint. The daemon builds images and manages containers, networks,
and volumes.

**Why do containers start faster than virtual machines?**
Containers share the host kernel and isolate processes with namespaces and
cgroups. A VM boots a complete guest operating system and virtualized kernel.

**What is a Dockerfile layer?**
Most Dockerfile instructions produce immutable filesystem layers. Docker can
reuse unchanged layers, so stable dependency instructions should appear before
frequently changing source-code copies.

**Why use a multi-stage build?**
It separates compilation, testing, and runtime concerns. Only required
artifacts reach the production stage, reducing image size, tools, and attack
surface.

## Runtime and networking

**What is the difference between `EXPOSE` and `ports`?**
`EXPOSE` documents an image's intended container port. Compose `ports` or
`docker run -p` publishes a container port on the host.

**How do Compose services communicate?**
Compose creates a bridge network and internal DNS. Services connect using
service names such as `database:5432`, not `localhost`.

**Why does `localhost` fail between containers?**
Inside a container, `localhost` points to that same container. Another service
must be reached through its DNS/service name on a shared network.

**What is the difference between running and healthy?**
Running means the container process exists. Healthy means its configured probe
is succeeding. A process can be running before its application is ready.

**What does `depends_on` guarantee?**
Basic `depends_on` controls start order. With
`condition: service_healthy`, Compose waits for a dependency health check; the
application must still handle later dependency failures.

## Storage and operations

**Volumes versus bind mounts?**
Docker manages named volumes and they are suited to persistent application
data. Bind mounts map a specific host path and are useful for development
source/configuration.

**Does `docker compose down` delete data?**
It removes containers and the default network. Named volumes remain unless
`--volumes`/`-v` is supplied.

**How do you troubleshoot a container?**
Check `docker compose ps`, logs, health-check history, configuration, resource
state, network membership, and runtime identity. Use `docker exec` only for
focused diagnostics.

## Security and delivery

**Why should a container run as non-root?**
It limits the impact of application compromise. Use an explicit unprivileged
UID and grant ownership only to required paths.

**What is an SBOM?**
A Software Bill of Materials inventories packages, versions, licenses, and
relationships. Teams use it to identify affected images when new CVEs appear.

**How should vulnerability findings be handled?**
Prioritize exploitability and criticality, upgrade when fixes exist, test base
image changes, document accepted upstream risks, apply compensating controls,
and continuously rebuild/rescan.

**What is an image registry?**
A registry stores versioned OCI images. GHCR and AWS ECR both support image
push/pull workflows; GHCR uses GitHub permissions, while ECR integrates with
AWS IAM, ECS, and EKS.

**Why avoid relying only on `latest`?**
`latest` can move and is not an auditable release identity. Deploy immutable
version tags or digests, with `latest` only as a convenience reference.

## Project scenario

The Release Management Platform uses Nginx as its only published endpoint.
FastAPI, PostgreSQL, and Redis remain on a private Compose network. Named
volumes persist data, health checks control dependency startup, the API runs as
UID `10001`, and multi-stage builds exclude test tooling from production.
Docker Scout scans the production image and an SPDX SBOM records its inventory.
