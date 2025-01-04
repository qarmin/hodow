#!/usr/bin/env python3
"""Writes src/vkt/tests/image_processing/cases.txt: the case names of dEQP-VK.image_processing.compute and .graphics (the api group is ported), one dotted path per line, relative to the group.

Upstream builds the names from the parameter space of the parameter tables of the block matching, box filter and weight sampling tests;
they are read from the mustpass list of the pinned revision instead, which holds exactly the names a run registers.

Run from hodow_cts/:  python3 scripts/gen_image_processing_cases.py
"""
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
MUSTPASS = ROOT.parent / "tmp" / "VK-GL-CTS" / "external" / "vulkancts" / "mustpass" / "main" / "vk-default" / "image-processing.txt"
OUT = ROOT / "src" / "vkt" / "tests" / "image_processing" / "cases.txt"
PREFIX = "dEQP-VK.image_processing."


def main():
    names = [line.strip()[len(PREFIX):] for line in MUSTPASS.read_text().splitlines() if line.startswith(PREFIX + "compute.") or line.startswith(PREFIX + "graphics.")]
    OUT.write_text("\n".join(names) + "\n")
    print(len(names), "cases")


if __name__ == "__main__":
    main()
