from fastapi.testclient import TestClient

from app import cache, database
from app.main import app

client = TestClient(app)


def test_root() -> None:
    response = client.get("/")

    assert response.status_code == 200
    assert response.json()["status"] == "running"


def test_health(monkeypatch) -> None:
    monkeypatch.setattr(database, "check_database", lambda: "connected")
    monkeypatch.setattr(cache, "check_cache", lambda: "connected")
    response = client.get("/health")

    assert response.status_code == 200
    assert response.json() == {
        "status": "healthy",
        "database": "connected",
        "cache": "connected",
    }


def test_health_reports_database_failure(monkeypatch) -> None:
    def unavailable() -> str:
        raise RuntimeError("database unavailable")

    monkeypatch.setattr(database, "check_database", unavailable)
    response = client.get("/health")

    assert response.status_code == 503
    assert response.json()["status"] == "unhealthy"


def test_stats_uses_cached_value(monkeypatch) -> None:
    monkeypatch.setattr(cache, "get_release_count", lambda: 4)
    response = client.get("/stats")

    assert response.status_code == 200
    assert response.json() == {"release_count": 4, "source": "cache"}