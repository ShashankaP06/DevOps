import os
from typing import Any

import psycopg
from psycopg.rows import dict_row

SCHEMA = """
CREATE TABLE IF NOT EXISTS services (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    owner VARCHAR(100) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS releases (
    id SERIAL PRIMARY KEY,
    service_id INTEGER NOT NULL REFERENCES services(id) ON DELETE CASCADE,
    version VARCHAR(50) NOT NULL,
    environment VARCHAR(30) NOT NULL,
    status VARCHAR(30) NOT NULL DEFAULT 'deployed',
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);
"""


def database_url() -> str:
    url = os.getenv("DATABASE_URL")
    if not url:
        raise RuntimeError("DATABASE_URL is not configured")
    return url


def connect() -> psycopg.Connection[dict[str, Any]]:
    return psycopg.connect(database_url(), row_factory=dict_row)


def initialize_database() -> None:
    with connect() as connection:
        connection.execute(SCHEMA)


def check_database() -> str:
    with connect() as connection:
        connection.execute("SELECT 1").fetchone()
    return "connected"


def create_service(name: str, owner: str) -> dict[str, Any]:
    query = """
        INSERT INTO services (name, owner)
        VALUES (%s, %s)
        RETURNING id, name, owner, created_at
    """
    with connect() as connection:
        result = connection.execute(query, (name, owner)).fetchone()
    if result is None:
        raise RuntimeError("Database did not return the created service")
    return result


def list_services() -> list[dict[str, Any]]:
    with connect() as connection:
        rows = connection.execute(
            "SELECT id, name, owner, created_at FROM services ORDER BY id"
        ).fetchall()
    return list(rows)


def create_release(
    service_id: int, version: str, environment: str
) -> dict[str, Any]:
    query = """
        INSERT INTO releases (service_id, version, environment)
        VALUES (%s, %s, %s)
        RETURNING id, service_id, version, environment, status, created_at
    """
    with connect() as connection:
        result = connection.execute(
            query, (service_id, version, environment)
        ).fetchone()
    if result is None:
        raise RuntimeError("Database did not return the created release")
    return result


def list_releases() -> list[dict[str, Any]]:
    query = """
        SELECT r.id, r.service_id, s.name AS service_name, r.version,
               r.environment, r.status, r.created_at
        FROM releases AS r
        JOIN services AS s ON s.id = r.service_id
        ORDER BY r.id
    """
    with connect() as connection:
        rows = connection.execute(query).fetchall()
    return list(rows)


def release_count() -> int:
    with connect() as connection:
        result = connection.execute(
            "SELECT COUNT(*) AS count FROM releases"
        ).fetchone()
    if result is None:
        raise RuntimeError("Database did not return the release count")
    return int(result["count"])
