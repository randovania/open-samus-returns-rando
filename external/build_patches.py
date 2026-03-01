#!/usr/bin/env python3
"""Compile the msr-remote-connector patch and regenerate the IPS patch files.

Usage (from the repo root or from within external/):
    python external/build_patches.py
"""

import subprocess
import sys
from pathlib import Path

HERE = Path(__file__).parent


def _run(*cmd: str) -> None:
    result = subprocess.run(cmd, check=False)
    if result.returncode != 0:
        sys.exit(result.returncode)


def main() -> None:
    magikoopa = HERE / "magikoopa-py" / "magikoopa.py"
    connector = HERE / "msr-remote-connector"
    recreate = HERE / "recreate_ips_patches.py"

    print("=== Step 1: compile and inject (magikoopa insert) ===")
    _run(sys.executable, str(magikoopa), "insert", str(connector))

    print("\n=== Step 2: regenerate IPS patches ===")
    _run(sys.executable, str(recreate))

    print("\nDone.")


if __name__ == "__main__":
    main()
