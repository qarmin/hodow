#!/usr/bin/env python3
"""Writes src/vkt/tests/dgc/{ext,nv}_cases.txt: the case names of dEQP-VK.dgc.ext and dEQP-VK.dgc.nv, one dotted path per line, relative to `dgc`.

The names are read from the mustpass list of the pinned revision. The bodies are not ported (see src/vkt/tests/dgc/mod.rs).

Run from hodow_cts/:  python3 scripts/gen_dgc_cases.py
"""
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
MUSTPASS = ROOT.parent / "tmp" / "VK-GL-CTS" / "external" / "vulkancts" / "mustpass" / "main" / "vk-default" / "dgc.txt"
OUT = ROOT / "src" / "vkt" / "tests" / "dgc"
PREFIX = "dEQP-VK.dgc."


def main():
    names = [line.strip()[len(PREFIX):] for line in MUSTPASS.read_text().splitlines() if line.startswith(PREFIX)]
    for flavour in ("ext", "nv"):
        selected = [name for name in names if name.startswith(flavour + ".")]
        (OUT / f"{flavour}_cases.txt").write_text("\n".join(selected) + "\n")
        print(flavour, len(selected), "cases")


if __name__ == "__main__":
    main()
