from contextlib import asynccontextmanager
from typing import Any

from fastapi import FastAPI, HTTPException, status
from fastapi.responses import JSONResponse
from psycopg.errors import ForeignKeyViolation, UniqueViolation

from app import cache, database
from app.models import ReleaseCreate, ServiceCreate


@asynccontextmanager
async def lifespan(_: FastAPI):
    database.initialize_database()
    yield

app = FastAPI(
    title="DevOps Release Management API",
    version="0.2.0",
    lifespan=lifespan,
)


@app.get("/")
def root() -> dict[str, str]:
    return {
        "application": "DevOps Release Management Platform",
        "status": "running",
    }


@app.get("/health")
def health() -> JSONResponse:
    try:
        database_status = database.check_database()
        cache_status = cache.check_cache()
    except Exception:
        return JSONResponse(
            status_code=status.HTTP_503_SERVICE_UNAVAILABLE,
            content={"status": "unhealthy", "dependency": "disconnected"},
        )
    return JSONResponse(
        content={
            "status": "healthy",
            "database": database_status,
            "cache": cache_status,
        }
    )


@app.post("/services", status_code=status.HTTP_201_CREATED)
def create_service(service: ServiceCreate) -> dict[str, Any]:
    try:
        return database.create_service(service.name, service.owner)
    except UniqueViolation as error:
        raise HTTPException(
            status_code=status.HTTP_409_CONFLICT,
            detail=f"Service '{service.name}' already exists",
        ) from error


@app.get("/services")
def get_services() -> list[dict[str, Any]]:
    return database.list_services()


@app.post("/releases", status_code=status.HTTP_201_CREATED)
def create_release(release: ReleaseCreate) -> dict[str, Any]:
    try:
        result = database.create_release(
            release.service_id, release.version, release.environment
        )
        cache.invalidate_release_count()
        return result
    except ForeignKeyViolation as error:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"Service {release.service_id} does not exist",
        ) from error


@app.get("/releases")
def get_releases() -> list[dict[str, Any]]:
    return database.list_releases()


@app.get("/stats")
def get_stats() -> dict[str, int | str]:
    count = cache.get_release_count()
    source = "cache"
    if count is None:
        count = database.release_count()
        cache.set_release_count(count)
        source = "database"
    return {"release_count": count, "source": source}