#!/usr/bin/env python3
"""Cumulative Python lesson: data, control flow, files, JSON, and logging."""

import json
import logging
from pathlib import Path

logging.basicConfig(level=logging.INFO, format="%(levelname)s: %(message)s")


def healthy_services(config: dict) -> list[str]:
    """Return names of services whose healthy flag is true."""
    return [
        service["name"]
        for service in config["services"]
        if service.get("healthy", False)
    ]


def main() -> int:
    config_path = Path(__file__).parents[1] / "data" / "deployment.json"
    try:
        config = json.loads(config_path.read_text(encoding="utf-8"))
        services = healthy_services(config)
    except (OSError, json.JSONDecodeError, KeyError) as error:
        logging.error("Could not process configuration: %s", error)
        return 1

    logging.info("Application: %s", config["application"])
    for service in services:
        print(f"healthy_service={service}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
