#!/usr/bin/env python3
"""Vendor the upstream C++ sources that hodow_cts has ported, and report drift.

Re-syncing with upstream is a recurring job, not a one-off. This keeps a copy of the
exact upstream files that were ported, pinned to the revision they were ported from,
so a later re-sync is a plain `git diff` over those copies rather than an
archaeological dig through 2.6M lines of history.

Two modes:

  --sync    copy the listed files from a VK-GL-CTS checkout into upstream/ and record
            the checkout's revision in upstream/COMMIT. Run this after porting a new
            file, and again when moving to a newer upstream: `git diff` then shows,
            line by line, exactly what changed and therefore what has to be mirrored
            into the Rust.

  --check   compare upstream/ against a checkout without writing anything, and list
            the ported files that upstream has changed since the pinned revision.
            This is the "what do I have to look at" report.

Apache-2.0 section 4 requires the copyright notices to be kept, which is why the files
are vendored verbatim, and why NOTICE at the repo root carries the attribution.

Usage:
    python3 hodow_cts/scripts/vendor_upstream.py --cts-dir tmp/VK-GL-CTS --sync
    python3 hodow_cts/scripts/vendor_upstream.py --cts-dir tmp/VK-GL-CTS --check
"""

from __future__ import annotations

import argparse
import filecmp
import shutil
import subprocess
import sys
from pathlib import Path

CRATE_DIR = Path(__file__).resolve().parent.parent
UPSTREAM_DIR = CRATE_DIR / "upstream"
COMMIT_FILE = UPSTREAM_DIR / "COMMIT"
MANIFEST_FILE = UPSTREAM_DIR / "FILES.txt"


def read_file_list() -> list[str]:
    if not MANIFEST_FILE.exists():
        print(f"error: {MANIFEST_FILE} missing", file=sys.stderr)
        sys.exit(2)
    return [
        line.strip()
        for line in MANIFEST_FILE.read_text().splitlines()
        if line.strip() and not line.strip().startswith("#")
    ]


def git_revision(cts_dir: Path) -> str:
    out = subprocess.run(
        ["git", "-C", str(cts_dir), "rev-parse", "HEAD"], capture_output=True, text=True, check=False
    )
    if out.returncode != 0:
        print(f"error: {cts_dir} is not a git checkout", file=sys.stderr)
        sys.exit(2)
    return out.stdout.strip()


def git_describe(cts_dir: Path) -> str:
    out = subprocess.run(
        ["git", "-C", str(cts_dir), "describe", "--tags"], capture_output=True, text=True, check=False
    )
    return out.stdout.strip() if out.returncode == 0 else "(no tag)"


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--cts-dir", required=True, type=Path, help="a VK-GL-CTS git checkout")
    mode = ap.add_mutually_exclusive_group(required=True)
    mode.add_argument("--sync", action="store_true", help="copy files in and re-pin the revision")
    mode.add_argument("--check", action="store_true", help="report which ported files upstream has changed")
    args = ap.parse_args()

    if not (args.cts_dir / "framework").is_dir():
        print(f"error: {args.cts_dir} does not look like a VK-GL-CTS checkout", file=sys.stderr)
        return 2

    files = read_file_list()
    revision = git_revision(args.cts_dir)
    pinned = COMMIT_FILE.read_text().strip() if COMMIT_FILE.exists() else "(none)"

    if args.sync:
        copied = 0
        for rel in files:
            src = args.cts_dir / rel
            if not src.is_file():
                print(f"error: {rel} not found in the checkout", file=sys.stderr)
                return 1
            dst = UPSTREAM_DIR / rel
            dst.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(src, dst)
            copied += 1
        COMMIT_FILE.write_text(revision + "\n")
        print(f"vendored {copied} file(s) at {git_describe(args.cts_dir)}")
        print(f"pinned revision: {pinned} -> {revision}")
        print("\nReview `git diff hodow_cts/upstream/` - every changed line there is a")
        print("change that has to be mirrored into the corresponding Rust file.")
        return 0

    # --check
    print(f"pinned:   {pinned}")
    print(f"checkout: {revision} ({git_describe(args.cts_dir)})")
    print()

    changed, missing, same = [], [], []
    for rel in files:
        src = args.cts_dir / rel
        dst = UPSTREAM_DIR / rel
        if not src.is_file():
            missing.append(rel)
        elif not dst.is_file():
            changed.append(rel)
        elif filecmp.cmp(src, dst, shallow=False):
            same.append(rel)
        else:
            changed.append(rel)

    for rel in changed:
        print(f"  CHANGED  {rel}")
    for rel in missing:
        print(f"  GONE     {rel}  (upstream removed or moved this file)")
    for rel in same:
        print(f"  same     {rel}")

    print()
    print(f"{len(same)} unchanged, {len(changed)} changed, {len(missing)} gone")
    if changed or missing:
        print("\nRe-run with --sync, then `git diff hodow_cts/upstream/` to see what to mirror.")
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
