#!/usr/bin/env python3
"""Writes src/vkt/tests/data_graph/cases.txt: the case names of dEQP-VK.data_graph, one dotted path per line, relative to the group.

Upstream builds the names from the parameter space of vktDataGraphTestProvider / the TOSA test resources (tens of thousands of combinations);
they are read from the mustpass list of the pinned revision instead, which holds exactly the names a run registers.

Run from hodow_cts/:  python3 scripts/gen_data_graph_cases.py
"""
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
MUSTPASS = ROOT.parent / "tmp" / "VK-GL-CTS" / "external" / "vulkancts" / "mustpass" / "main" / "vk-default" / "data-graph.txt"
OUT = ROOT / "src" / "vkt" / "tests" / "data_graph" / "cases.txt"
PREFIX = "dEQP-VK.data_graph."


def main():
    names = [line.strip()[len(PREFIX):] for line in MUSTPASS.read_text().splitlines() if line.startswith(PREFIX)]
    OUT.write_text("\n".join(names) + "\n")
    print(len(names), "cases")


if __name__ == "__main__":
    main()
