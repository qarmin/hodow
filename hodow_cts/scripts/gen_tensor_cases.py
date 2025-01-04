#!/usr/bin/env python3
"""Writes src/vkt/tests/tensor/cases.txt: the case names of dEQP-VK.tensor, one dotted path per line, relative to the group.

The names are read from the mustpass list of the pinned revision, which holds exactly the names a run registers (upstream builds them from format, shape and tiling tables).

Run from hodow_cts/:  python3 scripts/gen_tensor_cases.py
"""
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
MUSTPASS = ROOT.parent / "tmp" / "VK-GL-CTS" / "external" / "vulkancts" / "mustpass" / "main" / "vk-default" / "tensor.txt"
OUT = ROOT / "src" / "vkt" / "tests" / "tensor" / "cases.txt"
PREFIX = "dEQP-VK.tensor."


def main():
    names = [line.strip()[len(PREFIX):] for line in MUSTPASS.read_text().splitlines() if line.startswith(PREFIX)]
    OUT.write_text("\n".join(names) + "\n")
    print(len(names), "cases")


if __name__ == "__main__":
    main()
