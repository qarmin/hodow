#!/usr/bin/env python3
"""Write the vk-default mustpass case names that have no real body (not registered, or registered as a stub) to tmp/missing_vk.txt, with a per-group count.

Usage: python3 hodow_cts/scripts/missing_cases.py [--features vulkan]   (builds the binary; several minutes)
"""
import argparse
import collections
import subprocess
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import coverage  # noqa: E402


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--features", default="vulkan")
    args = ap.parse_args()
    import os

    os.environ["HODOW_CTS_FEATURES"] = args.features
    registered = set(coverage.list_cases(["--list"]))
    stubs = set(coverage.list_cases(["--list-stubs"]))
    upstream = coverage.upstream_cases([coverage.CTS_DIR / "external" / "vulkancts" / "mustpass" / "main" / "vk-default"], "dEQP-VK")
    missing = sorted(name for name in upstream if name not in registered or name in stubs)
    out = coverage.REPO_DIR / "tmp" / "missing_vk.txt"
    out.write_text("\n".join(missing) + "\n")
    groups = collections.Counter(".".join(name.split(".")[:2]) for name in missing)
    for group, count in groups.most_common():
        print(f"{count:8d} {group}")
    print(f"{len(missing)} missing of {len(upstream)}; names in {out}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
