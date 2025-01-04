#!/usr/bin/env python3
"""Static per-group gap table for dEQP-VK without running the binary.

Ported counts come from a saved `coverage.py --api vk` report (default tmp/cov.txt), whose
"per group being worked on" lines are `<group> <ported>/<total>`. The denominator is every
case of the vk-default mustpass (all sub-directories included). A mustpass case under no
reported group counts as not ported. Groups ported since the report was taken can be listed in
--extra (`<group-prefix> <count>` lines) and are credited against the zero-covered cases below them.

Usage: vk_static_gap.py [--cov tmp/cov.txt] [--extra tmp/vk_extra_ported.txt] [--range a-m] [--depth 3] [--out tmp/vk_gap_A.md]
"""
import argparse, collections, re
from pathlib import Path

REPO = Path(__file__).resolve().parents[2]
MP = REPO / "tmp/VK-GL-CTS/external/vulkancts/mustpass/main/vk-default"

ap = argparse.ArgumentParser()
ap.add_argument("--cov", default=str(REPO / "tmp/cov.txt"))
ap.add_argument("--extra", default=str(REPO / "tmp/vk_extra_ported.txt"))
ap.add_argument("--range", default="a-m")
ap.add_argument("--depth", type=int, default=3)
ap.add_argument("--out", default=None)
a = ap.parse_args()

cov = {}
pat = re.compile(r"^\s{4}(dEQP-VK\.\S+)\s+(\d+)/(\d+)")
in_sec = False
for line in open(a.cov, errors="ignore"):
    if "per group being worked on" in line:
        in_sec = True
    elif "group(s) with zero" in line or "per top-level group" in line:
        in_sec = False
    if in_sec:
        m = pat.match(line)
        if m:
            cov[m.group(1)] = (int(m.group(2)), int(m.group(3)))

extra = {}
if Path(a.extra).exists():
    for line in open(a.extra):
        p = line.split()
        if len(p) == 2 and p[0].startswith("dEQP-VK"):
            extra[p[0]] = int(p[1])

cases = []
for f in sorted(MP.rglob("*.txt")):
    for l in f.read_text(errors="ignore").splitlines():
        l = l.strip()
        if l.startswith("dEQP-VK."):
            cases.append(l)

lo, hi = a.range.split("-")
def in_range(top):
    return lo <= top[0] <= hi

total = collections.Counter()
zero = collections.Counter()
for c in cases:
    parts = c.split(".")
    key = ".".join(parts[:1 + a.depth])
    total[key] += 1
covered_in = collections.Counter()
for g, (p, t) in cov.items():
    parts = g.split(".")
    covered_in[".".join(parts[:1 + a.depth])] += p
for g, n in extra.items():
    covered_in[".".join(g.split(".")[:1 + a.depth])] += n

top_tot = collections.Counter(); top_port = collections.Counter()
rows = []
for k, t in total.items():
    top = k.split(".")[1]
    p = min(covered_in.get(k, 0), t)
    top_tot[top] += t; top_port[top] += p
    if in_range(top):
        rows.append((t - p, t, p, k))
rows.sort(reverse=True)
out = []
all_t = sum(top_tot.values()); all_p = sum(top_port.values())
rt = sum(v for k, v in top_tot.items() if in_range(k)); rp = sum(v for k, v in top_port.items() if in_range(k))
out.append(f"# dEQP-VK gap (cov report {a.cov}, extra credits {len(extra)})\n")
out.append(f"overall ported {all_p}/{all_t} = {100*all_p/all_t:.2f}%")
out.append(f"partition [{a.range}] ported {rp}/{rt} = {100*rp/max(rt,1):.2f}%, missing {rt-rp}\n")
out.append("## per top-level group\n")
for k in sorted(top_tot):
    if in_range(k):
        out.append(f"- {k}: {top_port[k]}/{top_tot[k]} missing {top_tot[k]-top_port[k]}")
out.append(f"\n## per depth-{a.depth} group, sorted by missing\n")
for m, t, p, k in rows:
    if m > 0:
        out.append(f"{m:8d} missing  {p}/{t}  {k}")
text = "\n".join(out)
if a.out:
    Path(a.out).write_text(text + "\n")
print(text[:6000])
