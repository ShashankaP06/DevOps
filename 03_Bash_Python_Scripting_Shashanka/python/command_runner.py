#!/usr/bin/env python3
"""Run an allow-listed system command safely with subprocess."""

import argparse
import subprocess

COMMANDS = {
    "git-version": ["git", "--version"],
    "python-version": ["python3", "--version"],
    "disk": ["df", "-h", "."],
}


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("check", choices=COMMANDS)
    args = parser.parse_args()

    try:
        result = subprocess.run(
            COMMANDS[args.check],
            check=True,
            capture_output=True,
            text=True,
            timeout=10,
        )
    except (OSError, subprocess.SubprocessError) as error:
        print(f"ERROR: {error}")
        return 1

    print(result.stdout.strip() or result.stderr.strip())
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
