#!/usr/bin/env python3
"""Compare hodow_cts against upstream deqp-vk / deqp-gles31 on the same driver.

This is the acceptance check for a ported group. It runs both binaries over the same
case list, on the same device, and requires that every case both of them know about
gets the same verdict. Anything else means the port and the original disagree about
what the test does - which, on a driver that is not itself broken, means the port is
wrong.

Both sides are needed because neither alone answers the question:
  - agreement with an analytical expectation only says the port is self-consistent;
  - agreement with upstream says the port tests the same thing upstream tests.

The upstream binaries are developer tools here. Neither is needed to build or run
hodow_cts.

Usage:
    python3 hodow_cts/scripts/diff_vs_deqp.py \\
        --deqp-vk /path/to/deqp-vk \\
        [--deqp-gles31 /path/to/deqp-gles31] \\
        [--case 'dEQP-VK.compute.*']

At least one upstream binary must be given; each one compares its own API's cases, so
passing both compares everything in one run.
"""

from __future__ import annotations

import argparse
import json
import os
import re
import subprocess
import sys
import tempfile
from pathlib import Path

CRATE_DIR = Path(__file__).resolve().parent.parent
REPO_DIR = CRATE_DIR.parent

# deqp writes its verdicts into a QPA log as
#   #beginTestCaseResult <name>
#   ...
#   #endTestCaseResult
# with the verdict on a StatusCode line. Parsing the log rather than stdout keeps the
# comparison independent of console formatting.
QPA_CASE_RE = re.compile(r"#beginTestCaseResult\s+(\S+)")
QPA_RESULT_RE = re.compile(r'<Result\s+StatusCode="([^"]+)"')

# hodow_cts spells verdicts the way qpTestResult does; deqp's QPA uses the same
# spellings, so no mapping table is needed. Kept explicit so a divergence is loud.
KNOWN_STATUSES = {
    "Pass",
    "Fail",
    "QualityWarning",
    "CompatibilityWarning",
    "NotSupported",
    "ResourceError",
    "InternalError",
    "Crash",
    "Timeout",
    "DeviceLost",
    "Waiver",
}


def parse_qpa(path: Path) -> dict[str, str]:
    results: dict[str, str] = {}
    current = None
    for line in path.read_text(errors="replace").splitlines():
        m = QPA_CASE_RE.match(line)
        if m:
            current = m.group(1)
            continue
        m = QPA_RESULT_RE.search(line)
        if m and current:
            results[current] = m.group(1)
            current = None
    return results


def parse_jsonl(path: Path) -> dict[str, str]:
    results: dict[str, str] = {}
    for line in path.read_text().splitlines():
        if not line.strip():
            continue
        record = json.loads(line)
        if record.get("kind") == "hodow_cts.run":
            continue
        # The result file uses SCREAMING_SNAKE_CASE on the wire; normalise to the
        # spelling deqp uses so the two sides are directly comparable.
        status = "".join(part.capitalize() for part in record["status"].split("_"))
        results[record["name"]] = status
    return results


# What differs between the two upstream binaries: the case-name prefix that selects
# its cases, the arguments it needs to run headless, and the environment that gets it
# to a display.
#
# `deqp-gles31`'s surfaceless target brings EGL up through
# eglGetDisplay(EGL_DEFAULT_DISPLAY) and gives up if that fails, so on a machine with
# no screen it needs Mesa's own EGL_PLATFORM to point it at the surfaceless platform.
# hodow_cts needs no such help - it tries the platforms itself - which is why this is
# set here rather than expected from the caller.
APIS = {
    "vk": {
        "prefix": "dEQP-VK.",
        "args": lambda args: [f"--deqp-vk-device-id={args.device_id}"],
        "env": {},
    },
    "gles31": {
        "prefix": "dEQP-GLES31.",
        "args": lambda args: [
            "--deqp-surface-type=pbuffer",
            "--deqp-surface-width=256",
            "--deqp-surface-height=256",
        ],
        "env": {"EGL_PLATFORM": "surfaceless"},
    },
}


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--deqp-vk", type=Path, default=None, help="path to the upstream deqp-vk binary")
    ap.add_argument("--deqp-gles31", type=Path, default=None, help="path to the upstream deqp-gles31 binary")
    ap.add_argument("--case", default=None, help="glob to restrict the comparison to")
    ap.add_argument("--hodow-cts", type=Path, default=None, help="path to hodow_cts (default: cargo run)")
    ap.add_argument("--device-id", type=int, default=1)
    args = ap.parse_args()

    binaries = [(api, path) for api, path in (("vk", args.deqp_vk), ("gles31", args.deqp_gles31)) if path]
    if not binaries:
        print("error: pass --deqp-vk and/or --deqp-gles31", file=sys.stderr)
        return 2
    for api, path in binaries:
        if not path.is_file():
            print(f"error: {path} not found. See hodow_cts/README.md, 'Working on the port'.", file=sys.stderr)
            return 2

    status = 0
    for api, path in binaries:
        if len(binaries) > 1:
            print(f"=== {path.name} ===")
        status = compare(api, path, args) or status
        if len(binaries) > 1:
            print()
    return status


def compare(api: str, binary: Path, args) -> int:
    spec = APIS[api]

    with tempfile.TemporaryDirectory() as td:
        td = Path(td)
        case_list = td / "cases.txt"
        ours_path = td / "hodow.jsonl"
        theirs_path = td / "deqp.qpa"

        # 1. Ask hodow_cts which cases it implements. Only those can be compared;
        #    upstream has ~1.68M and the port has a hand-picked subset.
        list_cmd = (
            [str(args.hodow_cts)]
            if args.hodow_cts
            else ["cargo", "run", "-q", "-p", "hodow_cts", "--"]
        )
        list_args = list_cmd + ["--list"] + (["--case", args.case] if args.case else [])
        listed = subprocess.run(list_args, capture_output=True, text=True, cwd=REPO_DIR)
        if listed.returncode != 0:
            print(f"error listing cases:\n{listed.stderr}", file=sys.stderr)
            return 1
        names = [l.strip() for l in listed.stdout.splitlines() if l.strip().startswith(spec["prefix"])]
        if not names:
            print("error: hodow_cts listed no cases", file=sys.stderr)
            return 1
        case_list.write_text("\n".join(names) + "\n")
        print(f"comparing {len(names)} case(s)\n")

        # 2. Run ours.
        run_args = list_cmd + [
            "--case-list", str(case_list),
            "--output", str(ours_path),
            "--device-id", str(args.device_id),
        ]
        subprocess.run(run_args, cwd=REPO_DIR, stdout=subprocess.DEVNULL)

        # 3. Run upstream, from its own directory - deqp resolves its data archive
        #    relative to the working directory.
        subprocess.run(
            [
                str(binary.resolve()),
                f"--deqp-caselist-file={case_list}",
                f"--deqp-log-filename={theirs_path}",
                *spec["args"](args),
            ],
            cwd=binary.resolve().parent,
            env={**os.environ, **spec["env"]},
            stdout=subprocess.DEVNULL,
        )

        if not ours_path.exists():
            print("error: hodow_cts produced no result file", file=sys.stderr)
            return 1
        if not theirs_path.exists():
            print(f"error: {binary.name} produced no log", file=sys.stderr)
            return 1

        ours = parse_jsonl(ours_path)
        theirs = parse_qpa(theirs_path)

    agree, disagree, missing = [], [], []
    for name in names:
        a, b = ours.get(name), theirs.get(name)
        if a is None or b is None:
            missing.append((name, a, b))
        elif a == b:
            agree.append((name, a))
        else:
            disagree.append((name, a, b))

    width = max((len(n) for n in names), default=0)
    for name, status in agree:
        print(f"  ok       {name:<{width}}  {status}")
    for name, a, b in disagree:
        print(f"  DIFFER   {name:<{width}}  hodow_cts={a}  {binary.name}={b}")
    for name, a, b in missing:
        print(f"  MISSING  {name:<{width}}  hodow_cts={a}  {binary.name}={b}")

    print()
    print(f"agree:    {len(agree)}/{len(names)}")
    print(f"differ:   {len(disagree)}")
    print(f"missing:  {len(missing)}")

    if disagree or missing:
        print("\nA disagreement means the port and the original do not do the same thing.")
        print("On a driver that is not itself broken, that is a bug in the port.")
        return 1

    print("\nEvery compared case agrees with upstream.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
