#!/usr/bin/env python3
"""Check an HTTP JSON endpoint and print a concise health summary."""

import argparse
import json
import logging
import urllib.error
import urllib.request

logging.basicConfig(level=logging.INFO, format="%(levelname)s: %(message)s")


def fetch_json(url: str, timeout: float) -> tuple[int, dict]:
    request = urllib.request.Request(
        url, headers={"Accept": "application/json", "User-Agent": "devops-lab"}
    )
    with urllib.request.urlopen(request, timeout=timeout) as response:
        return response.status, json.load(response)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--url", default="https://api.github.com")
    parser.add_argument("--timeout", type=float, default=10)
    args = parser.parse_args()

    try:
        status, payload = fetch_json(args.url, args.timeout)
    except (urllib.error.URLError, TimeoutError, json.JSONDecodeError) as error:
        logging.error("API check failed: %s", error)
        return 1

    logging.info("HTTP status: %s", status)
    print(f"endpoint={args.url}")
    print(f"json_fields={len(payload)}")
    print(f"current_user_url={payload.get('current_user_url', 'not provided')}")
    return 0 if 200 <= status < 300 else 1


if __name__ == "__main__":
    raise SystemExit(main())
