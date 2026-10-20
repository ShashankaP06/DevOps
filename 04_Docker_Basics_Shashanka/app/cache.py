import os

from redis import Redis

RELEASE_COUNT_KEY = "stats:release_count"


def client() -> Redis:
    url = os.getenv("REDIS_URL")
    if not url:
        raise RuntimeError("REDIS_URL is not configured")
    return Redis.from_url(url, decode_responses=True)


def check_cache() -> str:
    if not client().ping():
        raise RuntimeError("Redis did not respond to PING")
    return "connected"


def get_release_count() -> int | None:
    value = client().get(RELEASE_COUNT_KEY)
    return int(value) if value is not None else None


def set_release_count(count: int) -> None:
    client().set(RELEASE_COUNT_KEY, count, ex=60)


def invalidate_release_count() -> None:
    client().delete(RELEASE_COUNT_KEY)
