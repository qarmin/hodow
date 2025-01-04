#!/usr/bin/env python3
"""How much of the Khronos GL CTS mustpass lists the KHR-GL30..46 roots cover, by case name.

For every desktop version it compares the cases `hodow_cts --list` registers under `KHR-GL<version>` with that version's `gl<version>-main.txt`:

  registered  cases in the root
  in list     of those, the ones the mustpass list names
  not in list registered but absent from the list - a group added to the wrong package, or a name that is not upstream's; exits 1
  total       cases the list has
  missing     total - in list

A name match says the case exists, not that it does the same thing: `just cts-gl-diff` is the check of that.

Usage:
    python3 hodow_cts/scripts/khr_gl_coverage.py [--mustpass-dir DIR] [--hodow-cts PATH]
"""

from __future__ import annotations

import argparse
import subprocess
import sys
from pathlib import Path

CRATE_DIR = Path(__file__).resolve().parent.parent
REPO_DIR = CRATE_DIR.parent
VERSIONS = (30, 31, 32, 33, 40, 41, 42, 43, 44, 45, 46)
DEFAULT_MUSTPASS = REPO_DIR / "tmp" / "glcts-src" / "external" / "openglcts" / "data" / "gl_cts" / "data" / "mustpass" / "gl" / "khronos_mustpass" / "main"


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--mustpass-dir", type=Path, default=DEFAULT_MUSTPASS, help="directory holding gl<version>-main.txt (a glcts checkout, see `just glcts-build`)")
    ap.add_argument("--hodow-cts", type=Path, default=None, help="path to a hodow_cts built with --features gl (default: cargo run)")
    args = ap.parse_args()

    if not args.mustpass_dir.is_dir():
        print(f"error: no mustpass lists at {args.mustpass_dir}; run `just glcts-build` first or pass --mustpass-dir", file=sys.stderr)
        return 2

    command = [str(args.hodow_cts)] if args.hodow_cts else ["cargo", "run", "-q", "-p", "hodow_cts", "--features", "gl", "--"]
    listed = subprocess.run(command + ["--list"], capture_output=True, text=True, cwd=REPO_DIR)
    if listed.returncode != 0:
        print(f"error listing cases:\n{listed.stderr}", file=sys.stderr)
        return 2
    registered = [line.strip() for line in listed.stdout.splitlines() if line.strip().startswith("KHR-GL")]

    print(f"{'root':10} {'registered':>10} {'in list':>8} {'not in list':>12} {'total':>7} {'missing':>8}")
    wrong = 0
    totals = [0, 0, 0]
    for version in VERSIONS:
        root = f"KHR-GL{version}"
        must = {line.strip() for line in (args.mustpass_dir / f"gl{version}-main.txt").read_text().splitlines() if line.strip()}
        ours = {name for name in registered if name.split(".")[0] == root}
        not_in_list = sorted(ours - must)
        in_list = len(ours) - len(not_in_list)
        print(f"{root:10} {len(ours):>10} {in_list:>8} {len(not_in_list):>12} {len(must):>7} {len(must) - in_list:>8}")
        for name in not_in_list:
            print(f"    not in the {root} list: {name}")
        wrong += len(not_in_list)
        totals = [totals[0] + in_list, totals[1] + len(must), totals[2] + len(not_in_list)]

    print(f"\n{totals[0]} of {totals[1]} listed cases registered across the 11 roots ({100 * totals[0] / totals[1]:.2f}%); that is a name match, not a conformance claim.")
    return 1 if wrong else 0


if __name__ == "__main__":
    sys.exit(main())
