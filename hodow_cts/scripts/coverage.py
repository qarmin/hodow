#!/usr/bin/env python3
"""Report how much of the upstream CTS hodow_cts implements.

Reads the case list straight out of the binary (`--list`) and compares it against the
upstream mustpass files, so the numbers cannot drift from what actually runs. Each API
is reported separately, against its own mustpass: `dEQP-VK` against vk-default,
`dEQP-GLES31` against the AOSP gles31 mustpass.

Percentages are given against three different denominators on purpose. A single
"coverage %" would be misleading here: against the whole suite the number is
vanishingly small and always will be, while against a group that is being worked on it
is the number that says whether that group is finished. Both are true and they mean
different things.

Usage:
    python3 hodow_cts/scripts/coverage.py [--api vk|gles31] [--mustpass <dir>]
"""

from __future__ import annotations

import argparse
import subprocess
import sys
from collections import defaultdict
from pathlib import Path

CRATE_DIR = Path(__file__).resolve().parent.parent
REPO_DIR = CRATE_DIR.parent
CTS_DIR = REPO_DIR / "tmp" / "VK-GL-CTS"

# Where each API's mustpass lives in a checkout, and what its cases are called.
#
# The GLES tree keeps one mustpass per conformance release (3.2.2.x ... 3.2.6.x) plus
# `main`, and each release's list is a subset of the next. Only `main` is used, so the
# denominator is "the current suite" rather than the union of six historical ones -
# taking them all would count most cases six times and quietly deflate every
# percentage.
APIS = {
    "vk": {
        "prefix": "dEQP-VK.",
        "mustpass": lambda: [CTS_DIR / "external" / "vulkancts" / "mustpass" / "main" / "vk-default"],
        "label": "upstream vk-default mustpass",
    },
    "gles31": {
        "prefix": "dEQP-GLES31.",
        "mustpass": lambda: [CTS_DIR / "external" / "openglcts" / "data" / "gl_cts" / "data" / "mustpass" / "gles" / "aosp_mustpass" / "main" / "gles31-main.txt"],
        "label": "upstream AOSP gles31-main mustpass",
    },
}


def list_cases(extra: list[str]) -> list[str]:
    out = subprocess.run(
        ["cargo", "run", "-q", "-p", "hodow_cts", "--", *extra],
        capture_output=True,
        text=True,
        cwd=REPO_DIR,
    )
    if out.returncode != 0:
        print(f"error: could not list cases:\n{out.stderr}", file=sys.stderr)
        sys.exit(1)
    return [line.strip() for line in out.stdout.splitlines() if line.strip().startswith("dEQP-")]


def upstream_cases(paths: list[Path], prefix: str) -> list[str]:
    """Every case name in the given mustpass files or directories."""
    files: list[Path] = []
    for path in paths:
        if path.is_dir():
            files.extend(sorted(path.glob("*.txt")))
        elif path.is_file():
            files.append(path)
    cases: list[str] = []
    for f in files:
        cases.extend(line.strip() for line in f.read_text().splitlines() if line.strip().startswith(prefix))
    return cases


def group_of(name: str, depth: int) -> str:
    return ".".join(name.split(".")[: depth + 1])


def pct(n: int, d: int) -> str:
    return f"{(100.0 * n / d):.4f}%" if d else "n/a"


def report(api: str, ours: list[str], stubs: set[str], theirs: list[str], label: str) -> int:
    theirs_set = set(theirs)
    unknown = [c for c in ours if c not in theirs_set]

    print(f"implemented: {len(ours)}")
    if stubs:
        print(f"registered without an instance: {len(stubs)}  (not counted below)")
    print(f"{label}: {len(theirs)}")
    print()
    print(f"  of the whole suite:        {len(ours)}/{len(theirs)}  ({pct(len(ours), len(theirs))})")

    # Per-group, at the depth of the groups actually touched, so the leaf group being
    # worked on shows up rather than being averaged away.
    ours_by_leaf: dict[str, int] = defaultdict(int)
    for c in ours:
        ours_by_leaf[group_of(c, 3)] += 1

    theirs_by_leaf: dict[str, int] = defaultdict(int)
    for c in theirs:
        theirs_by_leaf[group_of(c, 3)] += 1

    print()
    print("  per group being worked on:")
    width = max((len(g) for g in ours_by_leaf), default=0)
    for group in sorted(ours_by_leaf):
        n, d = ours_by_leaf[group], theirs_by_leaf.get(group, 0)
        print(f"    {group:<{width}}  {n}/{d}  ({pct(n, d)})")

    # Also show the parent groups, which is what "how far into compute are we" means.
    ours_by_top: dict[str, int] = defaultdict(int)
    for c in ours:
        ours_by_top[group_of(c, 1)] += 1
    theirs_by_top: dict[str, int] = defaultdict(int)
    for c in theirs:
        theirs_by_top[group_of(c, 1)] += 1

    print()
    print("  per top-level group:")
    width = max((len(g) for g in ours_by_top), default=0)
    for group in sorted(ours_by_top):
        n, d = ours_by_top[group], theirs_by_top.get(group, 0)
        print(f"    {group:<{width}}  {n}/{d}  ({pct(n, d)})")

    if unknown:
        print()
        print(f"  WARNING: {len(unknown)} implemented case(s) are not in the {api} mustpass:")
        for c in unknown[:10]:
            print(f"    {c}")
        print("  A name that upstream does not have cannot be compared against it.")
        return 1

    return 0


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--api", choices=[*APIS, "all"], default="all", help="which API to report on")
    ap.add_argument("--mustpass", type=Path, default=None, help="override the mustpass directory (single --api only)")
    args = ap.parse_args()

    wanted = list(APIS) if args.api == "all" else [args.api]
    if args.mustpass and len(wanted) != 1:
        print("error: --mustpass needs a single --api", file=sys.stderr)
        return 2

    # One `--list` for both APIs; the prefix decides which report a name lands in.
    registered = list_cases(["--list"])
    stubs = set(list_cases(["--list-stubs"]))

    status = 0
    for api in wanted:
        spec = APIS[api]
        prefix = spec["prefix"]
        paths = [args.mustpass] if args.mustpass else spec["mustpass"]()
        theirs = upstream_cases(paths, prefix)

        if len(wanted) > 1:
            print(f"=== {prefix.rstrip('.')} ===")

        if not theirs:
            where = args.mustpass or (paths[0] if paths else CTS_DIR)
            print(f"skipped: no {api} mustpass found at {where}")
            print("It comes with a VK-GL-CTS checkout; see hodow_cts/README.md.")
            print()
            continue

        # The headline number counts only cases that actually run. A registered case
        # with no instance behind it is progress, but it is not coverage, and reporting
        # the two as one figure is how a percentage stops meaning anything.
        ours = [c for c in registered if c.startswith(prefix) and c not in stubs]
        status = report(api, ours, {c for c in stubs if c.startswith(prefix)}, theirs, spec["label"]) or status
        print()

    return status


if __name__ == "__main__":
    sys.exit(main())
