#!/usr/bin/env python3
"""Writes the reference images of dEQP-VK.dgc.ext.graphics.tess_state as binary files (NetPBM P6, 32x32, header included) from the arrays of
vktDGCGraphicsTessStateRefImages.hpp, for `include_bytes!` in graphics_tess_state_tests.rs. A pure text/binary generator: no cargo."""

import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
HPP = ROOT.parent / "tmp" / "glcts-src" / "external" / "vulkancts" / "modules" / "vulkan" / "device_generated_commands" / "vktDGCGraphicsTessStateRefImages.hpp"
UPSTREAM_HPP = ROOT / "upstream" / "external" / "vulkancts" / "modules" / "vulkan" / "device_generated_commands" / "vktDGCGraphicsTessStateRefImages.hpp"
OUT_DIR = ROOT / "src" / "vkt" / "tests" / "dgc" / "tess_state_ref"

HEADER = b"P6\n32 32\n255\n"


def main():
    src = UPSTREAM_HPP if UPSTREAM_HPP.exists() else HPP
    text = src.read_text()
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    count = 0
    for match in re.finditer(r"static const uint8_t (\w+)\[\] = \{(.*?)\};", text, re.S):
        name, body = match.group(1), match.group(2)
        values = bytes(int(v, 0) for v in re.findall(r"0x[0-9a-fA-F]+|\d+", body))
        assert values.startswith(HEADER), name
        assert len(values) == len(HEADER) + 32 * 32 * 3, (name, len(values))
        (OUT_DIR / f"{name}.ppm").write_bytes(values)
        count += 1
    print(f"wrote {count} images to {OUT_DIR}")


if __name__ == "__main__":
    main()
