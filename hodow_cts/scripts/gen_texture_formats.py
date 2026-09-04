#!/usr/bin/env python3
"""Generate src/tcu/texture.rs from the upstream tcu and vk sources.

`mapVkFormat` is a 140-entry switch and the ChannelOrder/ChannelType tables are
another 70 lines of one-to-one mapping. Retyping them by hand would be several
hundred opportunities for a typo, and a wrong entry here is not a build error - it is
a wrong verdict on real hardware, in a group of tests whose whole job is to decide
whether a driver handles a format correctly. So they are extracted mechanically and
this script is the record of how.

Run it after a re-sync, then check `git diff hodow_cts/src/tcu/texture.rs` against
`git diff hodow_cts/upstream/` to see that the two moved together.

Usage:
    python3 hodow_cts/scripts/gen_texture_formats.py [--cts-dir tmp/VK-GL-CTS]
"""

from __future__ import annotations

import argparse
import re
import subprocess
import sys
from pathlib import Path

CRATE_DIR = Path(__file__).resolve().parent.parent
REPO_DIR = CRATE_DIR.parent
OUT = CRATE_DIR / "src" / "tcu" / "texture.rs"


def enum_variants(hpp: str, name: str) -> list[str]:
    m = re.search(r"enum " + name + r"\s*\{(.*?)\};", hpp, re.S)
    if not m:
        raise SystemExit(f"could not find enum {name}")
    out = []
    for line in m.group(1).split("\n"):
        line = re.sub(r"//.*", "", line).strip().rstrip(",")
        if not line or line.startswith("/*"):
            continue
        v = line.split("=")[0].strip()
        if v and re.fullmatch(r"[A-Za-z_][A-Za-z0-9_]*", v) and not v.endswith("_LAST"):
            out.append(v)
    return out


def switch_table(cpp: str, signature: str) -> dict[str, int]:
    """Reads a `case TextureFormat::X: return N;` switch into a dict."""
    m = re.search(re.escape(signature) + r".*?\n\{.*?\n\}", cpp, re.S)
    if not m:
        raise SystemExit(f"could not find {signature}")
    table: dict[str, int] = {}
    pending: list[str] = []
    for line in m.group(0).split("\n"):
        c = re.search(r"case TextureFormat::(\w+):", line)
        if c:
            pending.append(c.group(1))
            continue
        r = re.search(r"return (\d+);", line)
        if r and pending:
            for k in pending:
                table[k] = int(r.group(1))
            pending = []
        elif "default" in line:
            pending = []
    return table


def map_vk_format_arms(image_util: str) -> list[str]:
    m = re.search(r"^tcu::TextureFormat mapVkFormat\(VkFormat format\)\n\{.*?\n\}", image_util, re.S | re.M)
    if not m:
        raise SystemExit("could not find mapVkFormat")

    entries: list[tuple[str, str, str]] = []
    pending: list[str] = []
    for line in m.group(0).split("\n"):
        c = re.match(r"\s*case (VK_FORMAT_\w+):", line)
        if c:
            pending.append(c.group(1))
            continue
        r = re.search(r"return TextureFormat\(TextureFormat::(\w+), TextureFormat::(\w+)\)", line)
        if r and pending:
            for fmt in pending:
                entries.append((fmt, r.group(1), r.group(2)))
            pending = []
        elif re.search(r"return |TCU_THROW|DE_FATAL|break;", line):
            pending = []

    arms = []
    for fmt, order, ctype in entries:
        name = fmt.removeprefix("VK_FORMAT_")
        # vulkanalia drops the vendor suffix for a format promoted into core, and
        # prefixes an underscore where the name would start with a digit.
        name = re.sub(r"_(KHR|EXT)$", "", name)
        if name[0].isdigit():
            name = "_" + name
        arms.append(
            f"        vk::Format::{name} => Some(TextureFormat::new("
            f"ChannelOrder::{order}, ChannelType::{ctype})),"
        )
    return arms


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--cts-dir", type=Path, default=REPO_DIR / "tmp" / "VK-GL-CTS")
    args = ap.parse_args()

    tcu_hpp = args.cts_dir / "framework" / "common" / "tcuTexture.hpp"
    tcu_cpp = args.cts_dir / "framework" / "common" / "tcuTexture.cpp"
    image_util = args.cts_dir / "external" / "vulkancts" / "framework" / "vulkan" / "vkImageUtil.cpp"
    for p in (tcu_hpp, tcu_cpp, image_util):
        if not p.is_file():
            print(f"error: {p} not found; is --cts-dir right?", file=sys.stderr)
            return 2

    hpp, cpp, iu = tcu_hpp.read_text(), tcu_cpp.read_text(), image_util.read_text()

    orders = enum_variants(hpp, "ChannelOrder")
    types = enum_variants(hpp, "ChannelType")
    num_channels = switch_table(cpp, "int getNumUsedChannels(TextureFormat::ChannelOrder order)")
    channel_size = switch_table(cpp, "int getChannelSize(TextureFormat::ChannelType type)")
    arms = map_vk_format_arms(iu)

    print(f"orders={len(orders)} types={len(types)} formats={len(arms)}")

    # The hand-written parts (channel_class, pixel_size, the sRGB/depth predicates)
    # live in the template below because they are judgement, not a table.
    existing = OUT.read_text() if OUT.exists() else ""
    if not existing:
        print("error: src/tcu/texture.rs missing; this script only refreshes the tables", file=sys.stderr)
        return 2

    # num_used_channels is total over ChannelOrder, so it returns a plain u32; only
    # channel_size is partial (packed types have no per-channel size). Keep that in
    # mind when regenerating - emitting Option there would reintroduce a dead arm.
    def replace_block(text: str, start_marker: str, end_marker: str, new_body: str) -> str:
        i = text.index(start_marker) + len(start_marker)
        j = text.index(end_marker, i)
        return text[:i] + "\n" + new_body + "\n" + text[j:]

    def arms_from(table: dict[str, int], variants: list[str], optional: bool) -> str:
        lines = []
        for v in variants:
            if v in table:
                value = f"Some({table[v]})" if optional else str(table[v])
                lines.append(f"            Self::{v} => {value},")
        return "\n".join(lines)

    out = existing
    out = replace_block(out, "// @generated:map_vk_format", "        _ => None,", "\n".join(arms))
    out = replace_block(
        out, "// @generated:num_used_channels", "        }\n    }", arms_from(num_channels, orders, optional=False)
    )
    out = replace_block(
        out, "// @generated:channel_size", "            _ => None,", arms_from(channel_size, types, optional=True)
    )
    OUT.write_text(out)

    subprocess.run(["rustfmt", "--edition", "2024", str(OUT)], cwd=CRATE_DIR, check=False)
    print(f"refreshed {OUT.relative_to(REPO_DIR)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
