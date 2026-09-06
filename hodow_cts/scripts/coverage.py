#!/usr/bin/env python3
"""Report how much of the upstream CTS hodow_cts implements.

Reads the case list straight out of the binary (`--list`) and compares it against the
upstream mustpass files, so the numbers cannot drift from what actually runs.

Percentages are given against three different denominators on purpose. A single
"coverage %" would be misleading here: against the whole suite the number is
vanishingly small and always will be, while against a group that is being worked on it
is the number that says whether that group is finished. Both are true and they mean
different things.

Usage:
    python3 hodow_cts/scripts/coverage.py [--mustpass <dir>]
"""

from __future__ import annotations

import argparse
import subprocess
import sys
from collections import defaultdict
from pathlib import Path

CRATE_DIR = Path(__file__).resolve().parent.parent
REPO_DIR = CRATE_DIR.parent
DEFAULT_MUSTPASS = REPO_DIR / "tmp" / "VK-GL-CTS" / "external" / "vulkancts" / "mustpass" / "main" / "vk-default"


def stub_cases() -> set[str]:
    """Cases that are registered but have no instance behind them.

    A case tree is often landed before the test logic - it is the part that can be
    checked against upstream on its own - but counting those as coverage would make the
    headline number mean nothing.
    """
    out = subprocess.run(
        ["cargo", "run", "-q", "-p", "hodow_cts", "--", "--list-stubs"],
        capture_output=True,
        text=True,
        cwd=REPO_DIR,
    )
    if out.returncode != 0:
        return set()
    return {line.strip() for line in out.stdout.splitlines() if line.strip().startswith("dEQP-VK.")}


def implemented_cases() -> list[str]:
    out = subprocess.run(
        ["cargo", "run", "-q", "-p", "hodow_cts", "--", "--list"],
        capture_output=True,
        text=True,
        cwd=REPO_DIR,
    )
    if out.returncode != 0:
        print(f"error: could not list cases:\n{out.stderr}", file=sys.stderr)
        sys.exit(1)
    return [line.strip() for line in out.stdout.splitlines() if line.strip().startswith("dEQP-VK.")]


def upstream_cases(mustpass: Path) -> list[str]:
    cases: list[str] = []
    for f in sorted(mustpass.glob("*.txt")):
        cases.extend(line.strip() for line in f.read_text().splitlines() if line.strip().startswith("dEQP-VK."))
    return cases


def group_of(name: str, depth: int) -> str:
    return ".".join(name.split(".")[: depth + 1])


def pct(n: int, d: int) -> str:
    return f"{(100.0 * n / d):.4f}%" if d else "n/a"


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--mustpass", type=Path, default=DEFAULT_MUSTPASS, help="upstream vk-default mustpass directory")
    args = ap.parse_args()

    if not args.mustpass.is_dir():
        print(f"error: no mustpass directory at {args.mustpass}", file=sys.stderr)
        print("It comes with a VK-GL-CTS checkout; see hodow_cts/README.md.", file=sys.stderr)
        return 2

    registered = implemented_cases()
    stubs = stub_cases()
    # The headline number counts only cases that actually run. A registered case with
    # no instance behind it is progress, but it is not coverage, and reporting the two
    # as one figure is how a percentage stops meaning anything.
    ours = [c for c in registered if c not in stubs]
    theirs = upstream_cases(args.mustpass)
    theirs_set = set(theirs)

    unknown = [c for c in ours if c not in theirs_set]

    print(f"implemented: {len(ours)}")
    if stubs:
        print(f"registered without an instance: {len(stubs)}  (not counted below)")
    print(f"upstream vk-default mustpass: {len(theirs)}")
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
        print(f"  WARNING: {len(unknown)} implemented case(s) are not in the upstream mustpass:")
        for c in unknown[:10]:
            print(f"    {c}")
        print("  A name that upstream does not have cannot be compared against it.")
        return 1

    return 0


if __name__ == "__main__":
    sys.exit(main())
